load dataCSP.mat
load dataset_BCIcomp1.mat
load labels_data_set_iii.mat
x=X(:,1:2);
t=T(:,1:2);
%训练模型，线性核，核尺度：1，框约束级别：985.4974326556996，标准化数据
svm= fitcsvm(x,y_train,...
    'KernelFunction', 'linear', ...
    'PolynomialOrder', [], ...
    'KernelScale', 1, ...
    'BoxConstraint', 985.4974326556996, ...
    'Standardize', true, ...
    'ClassNames', [1; 2]);
%绘制原始数据
color_L = [0 102 255] ./ 255;
color_R = [255, 0, 102] ./ 255;

pos = find(y_train==1);
plot(X(pos,1),X(pos,2),'x','Color',color_L,'LineWidth',1,'MarkerSize',5);

hold on
pos = find(y_train==2);
plot(X(pos,1),X(pos,2),'o','Color',color_R,'LineWidth',1,'MarkerSize',5);

legend('Left Hand','Right Hand')

plot(X(svm.IsSupportVector,1),...
    X(svm.IsSupportVector,2),'ko','MarkerSize',10,'DisplayName', '支持向量','LineWidth',1.2); % 绘制支持向量
% 绘制分类超平面
d = 0.001; % Step size of the grid
[x1Grid,x2Grid] = meshgrid(min(x(:,1)):d:max(x(:,1)),...
    min(x(:,2)):d:max(x(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];        % The grid
[~,scores1] = predict(svm,xGrid); % The scores
contour(x1Grid,x2Grid,reshape(scores1(:,2),size(x1Grid)),[0 0],'k','DisplayName', 'SVM分类超平面');
xlabel('f1','fontweight','bold')
ylabel('f2','fontweight','bold')
% predictedspecies = predict(svm,xGrid);
% gscatter(x1Grid(:), x2Grid(:), predictedspecies,'rg');
%计算测试集准确度
y=predict(svm,t);
acc=sum(y==y_test)/140