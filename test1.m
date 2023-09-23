%% 导入单条时间序列信号x（本例是脑电信号）
load dataset_BCIcomp1.mat
x=x_train(:,1,1);%去除前3秒的信号
% nx=zeros(768,3,140);
% for a=1:3
%     for b=1:140
%% CEEMDAN得出IMF
% xi=x(:,a,b);
[modes its]=ceemdan(x,0.2,100,20); %modes就包含了各个IMF

%% 快速独立成分分析
[icasig,A,W]=fastica(modes) ;% icasig就是源信号估计

%% 求出各源信号估计对应模糊熵值
[n,m]=size(icasig);
for i=1:n
fuzzyen(i)=Fuzzy_Entropy(4,0.2,icasig(i,:));
end

%% 利用判别法求出规律噪声熵值
new_fuzzyen=sort(fuzzyen);
k=2;
while new_fuzzyen(k+1)-new_fuzzyen(k)<new_fuzzyen(k)-new_fuzzyen(k-1)
            if k<n/2
            k=k+1;
            else k=fix(n/2);break;
            end
        end
k=k-1;%1：k都为伪迹成分

%% 将对应规律噪声置零
icasigCopy=icasig;
for i=1:k
    for j=1:n
        if fuzzyen(j)==new_fuzzyen(i)
            icasigCopy(j,:)=0;
        end
    end
end

%% ICA逆变换并叠加
new_modes=A*icasigCopy;
for j=1:m
new_x(j)=sum(new_modes(:,j));
end
%new_x=round(new_x)';% 四舍五入取整
% nx(:,a,b)=new_x;
%     end
% end
%% 画图比较观察
plot(x)
hold on
plot(new_x)
