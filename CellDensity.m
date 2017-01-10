% compute the cell density around vessel
function distance = CellDensity(vessel1,vessel2,cell,h)
CentroidData = CentroidDetec(cell);
[~, data1]=VesselLineRead(vessel1);
[~, data2]=VesselLineRead(vessel2);
data2(:,1) = data2(:,1) + round(size(cell,2)/2);
data = cat(1,data1,data2);
% I is indice position of vessel
data(:,3) = h*data(:,3);
CentroidData(:,3) = h*CentroidData(:,3);
[D,~] = pdist2(data,CentroidData,'euclidean','Smallest',1);
distance = mean(D);
figure;hist(D,50);