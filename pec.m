function [pe hist] = pec(y,m,t)
 
%  Calculate the permutation entropy
 
%  Input:   y: time series;
%           m: order of permuation entropy
%           t: delay time of permuation entropy, 
 
% Output: 
%           pe:    permuation entropy
%           hist:  the histogram for the order distribution
 
%Ref: G Ouyang, J Li, X Liu, X Li, Dynamic Characteristics of Absence EEG Recordings with Multiscale Permutation %     %                             Entropy Analysis, Epilepsy Research, doi: 10.1016/j.eplepsyres.2012.11.003
%     X Li, G Ouyang, D Richards, Predictability analysis of absence seizures with permutation entropy, Epilepsy %     %                            Research,  Vol. 77pp. 70-74, 2007
 
% revised by heda3 
 
 
 
ly = length(y);
permlist = perms(1:m);%全排列m！
c(1:length(permlist))=0;%
    
 for j=1:ly-t*(m-1)%K=n-(m-1)*t 有k个重构分量
     [a,iv]=sort(y(j:t:j+t*(m-1)));%按照数值大小升序排列 iv索引值 a为排序后的数值
     for jj=1:length(permlist)%m！
         if (abs(permlist(jj,:)-iv'))==0% iv可看做得到的符号序列
             c(jj) = c(jj) + 1 ;%累计每种排列对应m！中出现的次数
         end
     end
 end
hist = c;
 
c=c(find(c~=0));%找出非零元素索索引值对应的数值
p = c/sum(c);%计算每一种符号序列出现的概率
pe = -sum(p .* log(p));%shannon熵的形式