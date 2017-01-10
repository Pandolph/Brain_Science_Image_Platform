function CentroidData = CentroidDetec(cell)
cc=bwconncomp(cell); 
kk = struct2cell(regionprops(cc,'Centroid'));
kk = kk';
CentroidData=cell2mat(kk);
figure;
%plot3(data(:,1),data(:,2),data(:,3));
scatter3(CentroidData(:,1),CentroidData(:,2),CentroidData(:,3));axis equal;