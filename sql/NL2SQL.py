# 【1】导入各种必要的包
import os
import re
import json
import math
import numpy as np
from tqdm import tqdm_notebook as tqdm
from keras_bert import load_vocabulary, load_trained_model_from_checkpoint, Tokenizer, get_checkpoint_paths
import keras.backend as K
from keras.layers import Input, Dense, Lambda, Multiply, Masking, Concatenate
from keras.models import Model
from keras.preprocessing.sequence import pad_sequences
from keras.callbacks import Callback, ModelCheckpoint
from keras.utils.data_utils import Sequence
from keras.utils import multi_gpu_model



# 【2】这里是初始化模块
import json
import numpy as np
import pandas as pd
from keras_bert import Tokenizer

class Header:
    def __init__(self, names: list, types: list):
        self.names = names
        self.types = types

    def __getitem__(self, idx):
        return self.names[idx], self.types[idx]

    def __len__(self):
        return len(self.names)

    def __repr__(self):
        return ' | '.join(['{}({})'.format(n, t) for n, t in zip(self.names, self.types)])

class Table:
    def __init__(self, id, name, title, header: Header, rows, **kwargs):
        self.id = id
        self.name = name
        self.title = title
        self.header = header
        self.rows = rows
        self._df = None

    @property
    def df(self):
        if self._df is None:
            self._df = pd.DataFrame(data=self.rows,
                                    columns=self.header.names,
                                    dtype=str)
        return self._df

    def _repr_html_(self):
        return self.df._repr_html_()

class Tables:
    table_dict = None

    def __init__(self, table_list: list = None, table_dict: dict = None):
        self.table_dict = {}
        if isinstance(table_list, list):
            for table in table_list:
                self.table_dict[table.id] = table
        if isinstance(table_dict, dict):
            self.table_dict.update(table_dict)

    def push(self, table):
        self.table_dict[table.id] = table

    def __len__(self):
        return len(self.table_dict)

    def __add__(self, other):
        return Tables(
            table_list=list(self.table_dict.values()) +
            list(other.table_dict.values())
        )

    def __getitem__(self, id):
        return self.table_dict[id]

    def __iter__(self):
        for table_id, table in self.table_dict.items():
            yield table_id, table

def set_sql_compare_mode(mode):
    available_modes = {'all', 'agg', 'no_val', 'conn_and_agg'}
    if mode not in available_modes:
        raise ValueError('mode should be one of {}'.format(available_modes))
    cmp_func = getattr(SQL, 'equal_{}_mode'.format(mode))
    SQL.__eq__ = cmp_func

class SQL:
    op_sql_dict = {0: ">", 1: "<", 2: "==", 3: "!="}
    agg_sql_dict = {0: "", 1: "AVG", 2: "MAX", 3: "MIN", 4: "COUNT", 5: "SUM"}
    conn_sql_dict = {0: "", 1: "and", 2: "or"}

    def __init__(self, cond_conn_op: int, agg: list, sel: list, conds: list, **kwargs):
        self.cond_conn_op = cond_conn_op
        self.sel = []
        self.agg = []
        sel_agg_pairs = zip(sel, agg)
        sel_agg_pairs = sorted(sel_agg_pairs, key=lambda x: x[0])
        for col_id, agg_op in sel_agg_pairs:
            self.sel.append(col_id)
            self.agg.append(agg_op)
        self.conds = sorted(conds, key=lambda x: x[0])

    @classmethod
    def from_dict(cls, data: dict):
        return cls(**data)

    def keys(self):
        return ['cond_conn_op', 'sel', 'agg', 'conds']

    def __getitem__(self, key):
        return getattr(self, key)

    def to_json(self):
        return json.dumps(dict(self), ensure_ascii=False, sort_keys=True)

    def equal_all_mode(self, other):
        return self.to_json() == other.to_json()

    def equal_agg_mode(self, other):
        self_sql = SQL(cond_conn_op=0, agg=self.agg, sel=self.sel, conds=[])
        other_sql = SQL(cond_conn_op=0, agg=other.agg, sel=other.sel, conds=[])
        return self_sql.to_json() == other_sql.to_json()

    def equal_conn_and_agg_mode(self, other):
        self_sql = SQL(cond_conn_op=self.cond_conn_op,
                       agg=self.agg,
                       sel=self.sel,
                       conds=[])
        other_sql = SQL(cond_conn_op=other.cond_conn_op,
                        agg=other.agg,
                        sel=other.sel,
                        conds=[])
        return self_sql.to_json() == other_sql.to_json()

    def equal_no_val_mode(self, other):
        self_sql = SQL(cond_conn_op=self.cond_conn_op,
                       agg=self.agg,
                       sel=self.sel,
                       conds=[cond[:2] for cond in self.conds])
        other_sql = SQL(cond_conn_op=other.cond_conn_op,
                        agg=other.agg,
                        sel=other.sel,
                        conds=[cond[:2] for cond in other.conds])
        return self_sql.to_json() == other_sql.to_json()

    def __eq__(self, other):
        raise NotImplementedError('compare mode not set')

    def __repr__(self):
        repr_str = ''
        repr_str += "sel: {}\n".format(self.sel)
        repr_str += "agg: {}\n".format([self.agg_sql_dict[a]
                                        for a in self.agg])
        repr_str += "cond_conn_op: '{}'\n".format(
            self.conn_sql_dict[self.cond_conn_op])
        repr_str += "conds: {}".format(
            [[cond[0], self.op_sql_dict[cond[1]], cond[2]] for cond in self.conds])

        return repr_str

    def _repr_html_(self):
        return self.__repr__().replace('\n', '<br>')

class Question:
    def __init__(self, text):
        self.text = text

    def __repr__(self):
        return self.text

    def __getitem__(self, idx):
        return self.text[idx]

    def __len__(self):
        return len(self.text)

class Query:
    def __init__(self, question: Question, table: Table, sql: SQL = None):
        self.question = question
        self.table = table
        self.sql = sql

    def _repr_html_(self):
        repr_str = '{}<br>{}<br>{}'.format(
            self.table._repr_html_(),
            self.question.__repr__(),
            self.sql._repr_html_() if self.sql is not None else ''
        )
        return repr_str

class MultiSentenceTokenizer(Tokenizer):
    SPACE_TOKEN = '[unused1]'

    def _tokenize(self, text):
        r = []
        for c in text.lower():
            if c in self._token_dict:
                r.append(c)
            elif self._is_space(c):
                r.append(self.SPACE_TOKEN)
            else:
                r.append(self._token_unk)
        return r

    def _pack(self, *sents_of_tokens):
        packed_sents = []
        packed_sents_lens = []
        for tokens in sents_of_tokens:
            packed_tokens = tokens + [self._token_sep]
            packed_sents += packed_tokens
            packed_sents_lens.append(len(packed_tokens))
        return packed_sents, packed_sents_lens

    def tokenize(self, first_sent, *rest_sents):
        first_sent_tokens = [self._token_cls] + self._tokenize(first_sent)
        rest_sents_tokens = [self._tokenize(sent) for sent in rest_sents]
        all_sents_tokens = [first_sent_tokens] + rest_sents_tokens
        tokens, tokens_lens = self._pack(*all_sents_tokens)
        return tokens, tokens_lens

    def encode(self, first_sent, *rest_sents):
        tokens, tokens_lens = self.tokenize(first_sent, *rest_sents)
        token_ids = self._convert_tokens_to_ids(tokens)
        segment_ids = ([0] * tokens_lens[0]) + [1] * sum(tokens_lens[1:])
        return token_ids, segment_ids

class QueryTokenizer(Tokenizer):
    col_type_token_dict = {'text': '[unused11]', 'real': '[unused12]'}

    def _tokenize(self, text):
        r = []
        for c in text.lower():
            if c in self._token_dict:
                r.append(c)
            elif self._is_space(c):
                r.append('[unused1]')
            else:
                r.append('[UNK]')
        return r

    def _pack(self, *tokens_list):
        packed_tokens_list = []
        packed_tokens_lens = []
        for tokens in tokens_list:
            packed_tokens_list += [self._token_cls] + \
                tokens + [self._token_sep]
            packed_tokens_lens.append(len(tokens) + 2)
        return packed_tokens_list, packed_tokens_lens

    def encode(self, query: Query):
        tokens, tokens_lens = self.tokenize(query)
        token_ids = self._convert_tokens_to_ids(tokens)
        segment_ids = [0] * len(token_ids)
        header_indices = np.cumsum(tokens_lens)
        return token_ids, segment_ids, header_indices[:-1]

    def tokenize(self, query: Query):
        question_text = query.question.text
        table = query.table
        tokens_lists = []
        tokens_lists.append(self._tokenize(question_text))
        for col_name, col_type in table.header:
            col_type_token = self.col_type_token_dict[col_type]
            col_tokens = [col_type_token] + self._tokenize(col_name)
            tokens_lists.append(col_tokens)
        return self._pack(*tokens_lists)

def read_tables(table_file):
    tables = Tables()
    with open(table_file, encoding='utf-8') as f:
        for line in f:
            tb = json.loads(line)
            header = Header(tb.pop('header'), tb.pop('types'))
            table = Table(header=header, **tb)
            tables.push(table)
    return tables

def read_data(data_file, tables: Tables):
    queries = []
    with open(data_file, encoding='utf-8') as f:
        for line in f:
            data = json.loads(line)
            question = Question(text=data['question'])
            table = tables[data['table_id']]
            if 'sql' in data:
                sql = SQL.from_dict(data['sql'])
            else:
                sql = None
            query = Query(question=question, table=table, sql=sql)
            queries.append(query)
    return queries
    
    
    
# 【3】这里是优化器
from keras.legacy import interfaces
from keras.optimizers import Optimizer
import keras.backend as K

class RAdam(Optimizer):
    """RAdam optimizer.
    Default parameters follow those provided in the original Adam paper.
    # Arguments
        lr: float >= 0. Learning rate.
        beta_1: float, 0 < beta < 1. Generally close to 1.
        beta_2: float, 0 < beta < 1. Generally close to 1.
        epsilon: float >= 0. Fuzz factor. If `None`, defaults to `K.epsilon()`.
        decay: float >= 0. Learning rate decay over each update.
        amsgrad: boolean. Whether to apply the AMSGrad variant of this
            algorithm from the paper "On the Convergence of Adam and
            Beyond".
    # References
        - [RAdam - A Method for Stochastic Optimization]
          (https://arxiv.org/abs/1908.03265)
        - [On The Variance Of The Adaptive Learning Rate And Beyond]
          (https://arxiv.org/abs/1908.03265)
    """

    def __init__(self, lr=0.001, beta_1=0.9, beta_2=0.999,
                 epsilon=None, decay=0., **kwargs):
        super(RAdam, self).__init__(**kwargs)
        with K.name_scope(self.__class__.__name__):
            self.iterations = K.variable(0, dtype='int64', name='iterations')
            self.lr = K.variable(lr, name='lr')
            self.beta_1 = K.variable(beta_1, name='beta_1')
            self.beta_2 = K.variable(beta_2, name='beta_2')
            self.decay = K.variable(decay, name='decay')
        if epsilon is None:
            epsilon = K.epsilon()
        self.epsilon = epsilon
        self.initial_decay = decay

    @interfaces.legacy_get_updates_support
    def get_updates(self, loss, params):
        grads = self.get_gradients(loss, params)
        self.updates = [K.update_add(self.iterations, 1)]

        lr = self.lr
        if self.initial_decay > 0:
            lr = lr * (1. / (1. + self.decay * K.cast(self.iterations,
                                                      K.dtype(self.decay))))

        t = K.cast(self.iterations, K.floatx()) + 1
        beta_1_t = K.pow(self.beta_1, t)
        beta_2_t = K.pow(self.beta_2, t)
        rho = 2 / (1 - self.beta_2) - 1
        rho_t = rho - 2 * t * beta_2_t / (1 - beta_2_t)
        r_t = K.sqrt(
            K.relu(rho_t - 4) * K.relu(rho_t - 2) *
            rho / ((rho - 4) * (rho - 2) * rho_t)
        )
        flag = K.cast(rho_t > 4, K.floatx())

        ms = [K.zeros(K.int_shape(p), dtype=K.dtype(p)) for p in params]
        vs = [K.zeros(K.int_shape(p), dtype=K.dtype(p)) for p in params]
        self.weights = [self.iterations] + ms + vs

        for p, g, m, v in zip(params, grads, ms, vs):
            m_t = (self.beta_1 * m) + (1. - self.beta_1) * g
            v_t = (self.beta_2 * v) + (1. - self.beta_2) * K.square(g)
            mhat_t = m_t / (1 - beta_1_t)
            vhat_t = K.sqrt(v_t / (1 - beta_2_t))
            p_t = p - lr * mhat_t * \
                (flag * r_t / (vhat_t + self.epsilon) + (1 - flag))

            self.updates.append(K.update(m, m_t))
            self.updates.append(K.update(v, v_t))
            new_p = p_t

            # Apply constraints.
            if getattr(p, 'constraint', None) is not None:
                new_p = p.constraint(new_p)

            self.updates.append(K.update(p, new_p))
        return self.updates

    def get_config(self):
        config = {'lr': float(K.get_value(self.lr)),
                  'beta_1': float(K.get_value(self.beta_1)),
                  'beta_2': float(K.get_value(self.beta_2)),
                  'decay': float(K.get_value(self.decay)),
                  'epsilon': self.epsilon}
        base_config = super(RAdam, self).get_config()
        return dict(list(base_config.items()) + list(config.items()))
        


# 【4】这里是损失函数
import tensorflow as tf
from keras.backend.tensorflow_backend import _to_tensor, cast, flatten, epsilon


def custom_sparse_categorical_crossentropy(y_true, y_pred):
    return K_sparse_categorical_crossentropy(y_true, y_pred)


def K_sparse_categorical_crossentropy(target, output, from_logits=False, axis=-1):
    output_dimensions = list(range(len(output.get_shape())))
    if axis != -1 and axis not in output_dimensions:
        raise ValueError(
            '{}{}{}'.format(
                'Unexpected channels axis {}. '.format(axis),
                'Expected to be -1 or one of the axes of `output`, ',
                'which has {} dimensions.'.format(len(output.get_shape()))))
    # If the channels are not in the last axis, move them to be there:
    if axis != -1 and axis != output_dimensions[-1]:
        permutation = output_dimensions[:axis] + output_dimensions[axis + 1:]
        permutation += [axis]
        output = tf.transpose(output, perm=permutation)

    # Note: tf.nn.sparse_softmax_cross_entropy_with_logits
    # expects logits, Keras expects probabilities.
    if not from_logits:
        _epsilon = _to_tensor(epsilon(), output.dtype.base_dtype)
        output = tf.clip_by_value(output, _epsilon, 1 - _epsilon)
        output = tf.log(output)

    output_shape = output.get_shape()
    targets = cast(flatten(target), 'int64')
    logits = tf.reshape(output, [-1, tf.shape(output)[-1]])
    res = tf.nn.sparse_softmax_cross_entropy_with_logits(
        labels=targets,
        logits=logits)
    if len(output_shape) >= 3:
        # if our output includes timestep dimension
        # or spatial dimensions we need to reshape
        return tf.reshape(res, tf.shape(output)[:-1])
    else:
        return res
        
        
        
# 【5】导入文件
PATH="E:/SQL/data/"

train_table_file = PATH+'/train/train.tables.json'
train_data_file = PATH+'/train/train.json'

val_table_file = PATH+'/val/val.tables.json'
val_data_file = PATH+'/val/val.json'

test_table_file = PATH+'/test/test.tables.json'
test_data_file = PATH+'/test/test.json'

# Download pretrained BERT model from https://github.com/ymcui/Chinese-BERT-wwm
bert_model_path = 'E:\SQL\data\chinese_wwm_L-12_H-768_A-12'
paths = get_checkpoint_paths(bert_model_path)

train_tables = read_tables(train_table_file)
train_data = read_data(train_data_file, train_tables)

val_tables = read_tables(val_table_file)
val_data = read_data(val_data_file, val_tables)

test_tables = read_tables(test_table_file)
test_data = read_data(test_data_file, test_tables)



# 【6】查看json数据的一些基本信息
print("The length of the data")
print("train data and table: {} {}".format(len(train_data),len(train_tables)))
print("val data and table: {} {}".format(len(val_data),len(val_tables)))
print("the test data and table: {} {}\n".format(len(test_data),len(test_tables)))
print("Type of the dataset and its elements: {}".format(type(train_data),type(train_data[0])))
print("Type of the tables: {}".format(type(train_tables)))



# 【7】查看数据样例
# 每一条数据由自然语句与对应的sql语句以及所对应的数据表构成，存储格式类似于Python的字典
print(train_data[0].question)
print(train_data[0].sql)  # sql是一个类似字典的东西，有键值对，包含sel，agg，cond_conn_op，conds
print(train_data[0].table)  # table是一个数据表
print(train_data[0].table.header) # 每个table都有表头



# 【8】除去冗余字符及编码问题
def remove_brackets(s):
    '''
    函数功能：去除数据中的冗余字符，如括号
    '''
    return re.sub(r'[\(\（].*[\)\）]', '', s)  # re.sub函数进行字符替换

class QueryTokenizer(MultiSentenceTokenizer):
    """
    模块功能：编码query(问题+对应数据表的表头)并转化为整数序列
    使用指定的token([unused11]/[unused12])进行分类
    """
    col_type_token_dict = {'text': '[unused11]', 'real': '[unused12]'}
    def tokenize(self, query: Query, col_orders=None):
        """
        函数功能：对问题和列进行标记和连接
        函数参数：
            query (Query): query对象(包含问题+对应数据表的表头)
            col_orders (list or numpy.array): 重排表头对应的列
        函数返回:
            token_idss: token的ids(为bert编码做准备)
            segment_ids: segment的ids(为bert编码做准备)
            header_ids: columns的ids(即数据表每一列在数据表中的位置)
        """
        question_tokens = [self._token_cls] + self._tokenize(query.question.text)
        header_tokens = []
        
        if col_orders is None:
            col_orders = np.arange(len(query.table.header))
        
        header = [query.table.header[i] for i in col_orders]
        
        for col_name, col_type in header:
            col_type_token = self.col_type_token_dict[col_type]
            col_name = remove_brackets(col_name)
            col_name_tokens = self._tokenize(col_name)
            col_tokens = [col_type_token] + col_name_tokens
            header_tokens.append(col_tokens)
            
        all_tokens = [question_tokens] + header_tokens
        return self._pack(*all_tokens)
    
    def encode(self, query:Query, col_orders=None):
        tokens, tokens_lens = self.tokenize(query, col_orders)
        token_ids = self._convert_tokens_to_ids(tokens)
        segment_ids = [0] * len(token_ids)
        header_indices = np.cumsum(tokens_lens)
        return token_ids, segment_ids, header_indices[:-1]
        
token_dict = load_vocabulary(paths.vocab)
query_tokenizer = QueryTokenizer(token_dict)

# 查看给query编码的结果
print('Input Question:{}'.format(train_data[0].question))
print('Input Table Header:{}\n'.format(train_data[0].table.header))
print('Output Tokens:\n{}\n'.format(' '.join(query_tokenizer.tokenize(train_data[0])[0])))
print('Output ids:')
print('token_ids:{}\nsegment_ids:{}\nheader_ids:{}\n'.format(*query_tokenizer.encode(train_data[0])))
