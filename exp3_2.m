load dataPEC.mat
load dataset_BCIcomp1.mat
load labels_data_set_iii.mat
%训练模型，线性核，核尺度1，框约束级别985.4974326556996，标准化数据
svm= fitcsvm(pe_train,y_train,...
    'KernelFunction', 'linear', ...
    'PolynomialOrder', [], ...
    'KernelScale', 1, ...
    'BoxConstraint', 985.4974326556996, ...
    'Standardize', true, ...
    'ClassNames', [1; 2]);
%绘制初始数据
color_L = [0 102 255] ./ 255;
color_R = [255, 0, 102] ./ 255;

pos = find(y_train==1);
plot(pe_train(pos,1),pe_train(pos,2),'x','Color',color_L,'LineWidth',1,'MarkerSize',5);

hold on
pos = find(y_train==2);
plot(pe_train(pos,1),pe_train(pos,2),'o','Color',color_R,'LineWidth',1,'MarkerSize',5);

legend('Left Hand','Right Hand')

plot(pe_train(svm.IsSupportVector,1),...
    pe_train(svm.IsSupportVector,2),'ko','MarkerSize',10,'DisplayName', '支持向量','LineWidth',1.2); % 绘制支持向量
% 绘制分类超平面
d = 0.001; % Step size of the grid
[x1Grid,x2Grid] = meshgrid(min(pe_train(:,1)):d:max(pe_train(:,1)),...
    min(pe_train(:,2)):d:max(pe_train(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];        % The grid
[~,scores1] = predict(svm,xGrid); % The scores
contour(x1Grid,x2Grid,reshape(scores1(:,2),size(x1Grid)),[0 0],'k','DisplayName', 'SVM分类超平面');
xlabel('C3','fontweight','bold')
ylabel('C4','fontweight','bold')
% predictedspecies = predict(svm,xGrid);
% gscatter(x1Grid(:), x2Grid(:), predictedspecies,'rg');
%计算测试集准确率
y=predict(svm,pe_test);
acc=sum(y==y_test)/140