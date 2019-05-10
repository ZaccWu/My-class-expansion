from scipy import stats
import math

#A.单正态总体参数的置信区间
#A1.方差已知求均值的置信区间
#该函数需传入样本、总体方差、alpha
def sN_mu_sigk(sample,sigma2,alpha):
    X=sum(sample)/len(sample)
    u=stats.norm.isf(alpha/2)
    sigma=math.sqrt(sigma2)
    c=X-u*sigma/math.sqrt(len(sample))
    d=X+u*sigma/math.sqrt(len(sample))
    print("[{:.5f},{:.5f}]".format(c,d))

#A2.方差未知求均值的置信区间
#该函数需传入样本大小、样本均值、样本方差、alpha
def sN_mu_siguk(n,X,Var,alpha):
    t=stats.t.isf(alpha/2,n-1)
    c=X-sqrt(Var)*t/math.sqrt(n)
    d=X+sqrt(Var)*t/math.sqrt(n)
    print("[{:.5f},{:.5f}]".format(c,d))

#A3.均值已知求方差的置信区间
#该函数需传入样本、均值、alpha
def sN_sig_muk(sample,mu,alpha):
    n=len(sample)
    chi2_1=stats.chi2.isf(alpha/2,n)
    chi2_2=stats.chi2.isf(1-alpha/2,n)
    Smu2=(sum([(i-mu)**2 for i in sample])/n)
    c=n*Smu2/chi2_1
    d=n*Smu2/chi2_2
    print("[{:.5f},{:.5f}]".format(c,d))

#A4.均值未知求方差的置信区间
#该函数需传入样本大小、样本方差、alpha
def sN_sig_muuk(n,Var,alpha):
    chi2_1=stats.chi2.isf(alpha/2,n-1)
    chi2_2=stats.chi2.isf(1-alpha/2,n-1)
    c=(n-1)*Var/chi2_1
    d=(n-1)*Var/chi2_2
    print("[{:.5f},{:.5f}]".format(c,d))


#B.双正太总体参数均值差置信区间
#B2.方程未知但方差相等
#传入两个样本数组和alpha
def dN_mugap_sigukeq1(sample_x,sample_y,alpha):
    m=len(sample_x)
    n=len(sample_y)
    X=sum(sample_x)/len(sample_x)
    Y=sum(sample_y)/len(sample_y)
    t=stats.t.isf(alpha/2, m+n-2) 
    Sw2=(sum([(i-X)**2 for i in sample_x])+sum([(j-Y)**2 for j in sample_y]))/(m+n-2)
    Sw=math.sqrt(Sw2)
    c=Y-X-t*Sw*math.sqrt((m+n)/(m*n))
    d=Y-X+t*Sw*math.sqrt((m+n)/(m*n))
    print("[{:.5f},{:.5f}]".format(c,d))
#传入两个样本的容量、均值、方差以及alpha
def dN_mugap_sigukeq2(m,n,X,Y,Var1,Var2,alpha):
    t=stats.t.isf(alpha/2,m+n-2)
    Sw2=((m-1)*Var1+(n-1)*Var2)/(m+n-2)
    Sw=math.sqrt(Sw2)
    c=Y-X-t*Sw*math.sqrt(1/m+1/n)
    d=Y-X+t*Sw*math.sqrt(1/m+1/n)
    print("[{:.5f},{:.5f}]".format(c,d))

#B3.方差未知但利用大样本性质
#传入两个样本的容量、均值、方差以及alpha
def dN_mugap_sigukv(m,n,X,Y,Var1,Var2,alpha):
    u=stats.norm.isf(alpha/2)
    c=Y-X-u*math.sqrt(Var1/m+Var2/n)
    d=Y-X+u*math.sqrt(Var1/m+Var2/n)
    print("[{:.5f},{:.5f}]".format(c,d))


#C.双正太总体参数均值差置信区间
#C2.均值未知
#掺入两个样本的容量、方差以及alpha
def dN_sigpr_muuk(m,n,Var1,Var2,alpha):
    f1=stats.f.isf(alpha/2,m-1,n-1)
    f2=stats.f.isf(1-alpha/2,m-1,n-1)
    c=Var1/(Var2*f1)
    d=Var1/(Var2*f2)
    print("[{:.5f},{:.5f}]".format(c,d))
