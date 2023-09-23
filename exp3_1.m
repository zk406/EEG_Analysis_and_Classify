load dataPEC.mat
load dataset_BCIcomp1.mat
load labels_data_set_iii.mat
lda=fitcdiscr(pe_train,y_train);%训练模型

%绘制原始数据
color_L = [0 102 255] ./ 255;
color_R = [255, 0, 102] ./ 255;

pos = find(y_train==1);
plot(pe_train(pos,1),pe_train(pos,2),'x','Color',color_L,'LineWidth',2);

hold on
pos = find(y_train==2);
plot(pe_train(pos,1),pe_train(pos,2),'o','Color',color_R,'LineWidth',2);

legend('Left Hand','Right Hand')
hold on
%绘制分界线
lx = get(gca, 'Xlim');
ly = -(lda.Coeffs(1, 2).Const + lda.Coeffs(1, 2).Linear(1) .* lx) / lda.Coeffs(1, 2).Linear(2);
plot(lx, ly, 'k','DisplayName', 'LDA分界线');
xlabel('C3','fontweight','bold')
ylabel('C4','fontweight','bold')
%计算测试集准确率
y=predict(lda,pe_test);
acc=sum(y==y_test)/140

