load dataset_BCIcomp1.mat
load labels_data_set_iii.mat
pe_train=zeros(140,2);
pe_test=zeros(140,2);
x_train=x_train(512:768,:,:);
x_test=x_test(512:768,:,:);
for j=1:140
    [pe_train(j,1),~] = pec(x_train(:,1,j),5,2);
    [pe_test(j,1),~] = pec(x_test(:,1,j),5,2);
    [pe_train(j,2),~] = pec(x_train(:,3,j),5,2);
    [pe_test(j,2),~] = pec(x_test(:,3,j),5,2);
end

color_L = [0 102 255] ./ 255;
color_R = [255, 0, 102] ./ 255;

pos = find(y_train==1);
plot(pe_train(pos,1),pe_train(pos,2),'x','Color',color_L,'LineWidth',2);

hold on
pos = find(y_train==2);
plot(pe_train(pos,1),pe_train(pos,2),'o','Color',color_R,'LineWidth',2);

legend('Left Hand','Right Hand')
xlabel('C3','fontweight','bold')
ylabel('C4','fontweight','bold')

figure;
pos = find(y_test==1);
plot(pe_test(pos,1),pe_test(pos,2),'x','Color',color_L,'LineWidth',2);

hold on
pos = find(y_test==2);
plot(pe_test(pos,1),pe_test(pos,2),'o','Color',color_R,'LineWidth',2);
legend('Left Hand','Right Hand')
xlabel('C3','fontweight','bold')
ylabel('C4','fontweight','bold')