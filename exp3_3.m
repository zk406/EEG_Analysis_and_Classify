load dataPEC.mat
load dataset_BCIcomp1.mat
load labels_data_set_iii.mat
%训练模型，距离度量：'Correlation'，邻点个数：29，距离权重：反距离，标准化数据
knn = fitcknn(pe_train,y_train,...
    'Distance', 'Correlation', ...
    'Exponent', [], ...
    'NumNeighbors', 29, ...
    'DistanceWeight', 'Inverse', ...
    'Standardize', true, ...
    'ClassNames', [1; 2]);
x1range = min(pe_train(:,1)):.001:max(pe_train(:,1));
x2range = min(pe_train(:,2)):.001:max(pe_train(:,2));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];
predictedspecies = predict(knn,XGrid);
hold on;
gscatter(xx1(:), xx2(:), predictedspecies,'cy');%绘制分类边界
%绘制初始数据
color_L = [0 102 255] ./ 255;
color_R = [255, 0, 0] ./ 255;

pos = find(y_train==1);
plot(pe_train(pos,1),pe_train(pos,2),'x','Color',color_L,'LineWidth',1);

hold on
pos = find(y_train==2);
plot(pe_train(pos,1),pe_train(pos,2),'o','Color',color_R,'LineWidth',1);

legend('Predict Left Hand','Predict Right Hand','Left Hand','Right Hand')
xlabel('C3','fontweight','bold')
ylabel('C4','fontweight','bold')
%计算测试集准确率
y=predict(knn,pe_test);
acc=sum(y==y_test)/140


