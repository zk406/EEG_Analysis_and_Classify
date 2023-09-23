load dataset_BCIcomp1.mat
load dataeemd.mat
c3=x_train(:,1,1);
modes = eemd(c3,0.2,100);
pos=zeros(11,4);
for i=1:11
    subplot(11,1,i);plot(modes(:,i));
    pos(i,:)=axis;
end
xlabel('采样点','fontweight','bold')
ylabel('幅值','fontweight','bold','position',[-75,0.2])
nx(:,1,1)=(modes(:,1)+modes(:,2)+modes(:,3))/3;
figure;
plot(c3);
hold on
plot(nx(:,1,1));
xlabel('采样点');
ylabel('幅值');
legend('处理前','处理后');
% c4=x_test(:,3,1);
% modes = eemd(c4,0.2,100); 
% nx(:,3,1)=modes(:,1)+modes(:,2)+modes(:,3);
% cz=x_test(:,2,1);
% modes = eemd(cz,0.2,100); 
% nx(:,2,1)=modes(:,1)+modes(:,2)+modes(:,3);
% fs = 128;                             % sample frequency (Hz)
% t = 0:1/fs:10-1/fs;                   % 10 second span time vector
% x = c3;
% y = abs(fft(x));
% m = y(1:length(y)/2);
% n = length(x);          % number of samples
% f = (1:n/2)*(fs/n);     % frequency range
% plot(f,m)

