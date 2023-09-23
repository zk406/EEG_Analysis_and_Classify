load dataCSP.mat
load dataset_BCIcomp1.mat
load labels_data_set_iii.mat
x=X(:,1:2);
t=T(:,1:2);
%训练模型，距离度量'Cityblock'，邻点个数48，距离权重：等距离，标准化数据
knn = fitcknn(x,y_train,...
    'Distance', 'Cityblock', ...
    'Exponent', [], ...
    'NumNeighbors', 48, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', [1; 2]);
x1range = min(x(:,1)):.0001:max(x(:,1));
x2range = min(x(:,2)):.0001:max(x(:,2));
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];
predictedspecies = predict(knn,XGrid);
hold on;
gscatter(xx1(:), xx2(:), predictedspecies,'cy');%绘制分类边界
%绘制初始数据
color_L = [0 102 255] ./ 255;
color_R = [255, 0, 0] ./ 255;

pos = find(y_train==1);
plot(X(pos,1),X(pos,2),'x','Color',color_L,'LineWidth',1);

hold on
pos = find(y_train==2);
plot(X(pos,1),X(pos,2),'o','Color',color_R,'LineWidth',1);

legend('Predict Left Hand','Predict Right Hand','Left Hand','Right Hand')
xlabel('f1','fontweight','bold')
ylabel('f2','fontweight','bold')
%计算测试集准确度
y=predict(knn,t);
acc=sum(y==y_test)/140


