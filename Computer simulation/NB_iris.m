function NB_iris(df)
    % description: clasify iris using NB algorithm
    % requirement: the input of the function will be a dataset(a matrix with 4 feature columns and 1 target column)
    % in this case there are 3 differnet targets
    
    % please input the following command:
    % >> filename='FILE_PATH/iris.csv';
    % >> df=csvread(filename);
    % >> NB_iris(df)

    row=size(df,1);
    column=size(df,2);
    train_row=row*0.6;   % how we split the data

    % rearrange the matrix in rows
    r=randperm(row);
    df=df(r,:);


    % split the data
    df_train=df(1:train_row,:);
    df_test=df(train_row+1:row,:);

    % category different features
    target1=df_train(df_train(:,5)==1,:);
    target2=df_train(df_train(:,5)==2,:);
    target3=df_train(df_train(:,5)==3,:);

    % targets' prior probabilities
    tar=tabulate(df_train(:,5));
    tarpr=zeros(3,1);
    for i=1:3
        row_index=(tar==i);
        temp=tar(row_index,:);
        tarpr(i)=temp(3); 
    end

    % count the percentage
    % features for target==1
    tar1=cell(4,1);
    for i=1:4
        tar1{i}=tabulate(target1(:,i));
    end
    % features for target==2
    tar2=cell(4,1);
    for i=1:4
        tar2{i}=tabulate(target2(:,i));
    end
    % features for target==3
    tar3=cell(4,1);
    for i=1:4
        tar3{i}=tabulate(target3(:,i));
    end
    
    % count the accuracy
    right=0;
    wrong=0;
    
    % input the test data
    for m=1:(row-train_row)
        new_input=df_test(m,:);
        result=zeros(1,3);
        % target 1
        per1=zeros(1,4);
        for i=1:4
            mat1=cell2mat(tar1(i));
            row_index1=(mat1(:,1)==new_input(i));
            if sum(row_index1)==0    % no such value!
                per1(i)=0;
            else
                temp1=mat1(row_index1,:);
                per1(i)=temp1(3);  % conditional probability for feature i
            end
        end
        result(1)=per1(1)*per1(2)*per1(3)*per1(4)*tarpr(1);

        % target 2
        per2=zeros(1,4);
        for i=1:4
            mat2=cell2mat(tar2(i));
            row_index2=(mat2(:,1)==new_input(i));
            if sum(row_index2)==0
                per2(i)=0;
            else
                temp2=mat2(row_index2,:);
                per2(i)=temp2(3);  % conditional probability for feature i
            end
        end
        result(2)=per2(1)*per2(2)*per2(3)*per2(4)*tarpr(2);

        % target 3
        per3=zeros(1,4);
        for i=1:4
            mat3=cell2mat(tar3(i));
            row_index3=(mat3(:,1)==new_input(i));
            if sum(row_index3)==0
                per3(i)=0;
            else
                temp3=mat3(row_index3,:);
                per3(i)=temp3(3);  % conditional probability for feature i
            end
        end
        result(3)=per3(1)*per3(2)*per3(3)*per3(4)*tarpr(3);

        prediction=find(result==max(result));       % the target with maximum posterior will be the prediction
        if prediction==new_input(5)
            right=right+1;
            % fprintf("right! %d",right);
        else
            wrong=wrong+1;
            % fprintf("wrong! %d",wrong);
        end
    end
    accuracy=right./(right+wrong);
    fprintf("Accuracy: %.4f\n",accuracy);
    
    % check my code:
    % fprintf("input: %.f %.f %.f %.f %d\n",new_input(1),new_input(2),new_input(3),new_input(4),new_input(5));
    % fprintf("Prob: 1: %.f 2: %.f 3: %.f\n",result(1),result(2),result(3));
    % fprintf("Target prediction: %d\n",prediction);
end

