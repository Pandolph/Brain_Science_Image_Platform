function pernum = NumCell(manualcell,cell) 
c = CentroidDetec(cell);
m = CentroidDetec(manualcell);
pernum = length(c)/length(m);
h = figure;
scatter3(m(1:end,1),m(1:end,2),m(1:end,3),'MarkerFaceColor','blue');
hold on 
scatter3(c(1:end,1),c(1:end,2),c(1:end,3),'MarkerFaceColor','red');
axis equal