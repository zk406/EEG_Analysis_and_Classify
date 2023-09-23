TSData = ncread('E:\data\yFTS.nc','ts');
subplot(11,2,1);
plot(TSData);
IMF = eemd(TSData(:),0.25,1000);
for i=2:9
    subplot(11,2,i);
    plot(IMF(:,i), 'r');
    hold on
    plot(1:0.8:2000, 0, 'k');
    set(gca,'YLim',[-1,1],'YTick',[-1:1])
end
Y =fft(detrend(IMF(:,2)));       %����FFT�任
N = length(Y);    %FFT�任�����ݳ���
power = abs(Y(1:N/2)).^2;  %������
nyquist = 1/2;
freq = (1:N/2)/(N/2)*nyquist; %��Ƶ��
subplot(11,2,10);
plot(freq,power); grid on     %���ƹ�����ͼ
xlabel('Ƶ��')
ylabel('����')
title('������ͼ')
period = 1./freq;                %��������
subplot(11,2,11);
plot(period,power); grid on  %�������ڣ�����������
ylabel('����')
xlabel('����')
title('���ڡ�������ͼ')
[mp,index] = max(power);       %�������������Ӧ���±�
T_mean=period(index);            %���±����ƽ������