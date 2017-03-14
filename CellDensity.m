% compute the cell density around vessel
function [distance2d, distance3d] = CellDensity(vessel1,vessel2,cell,h)
CentroidData = CentroidDetec(cell);
figure;scatter3(CentroidData(:,1),CentroidData(:,2),CentroidData(:,3));axis equal;
data = CombineVessel(vessel1, vessel2, cell);
figure;scatter3(data(1:end,1),data(1:end,2),data(1:end,3));axis equal

%3d distance
data2(:,3) = h*data(:,3);
CentroidData2(:,3) = h*CentroidData(:,3);
[D,I] = pdist2(data2,CentroidData2,'euclidean','Smallest',1);% I is indice position of vessel
distance3d = mean(D);
figure; plot(sort(D));
figure;hist(D,50);
temp = round(max(D))+1;
y = hist(D,temp);
figure; plot(y);
xlswrite('cvdistance3d.xlsx',D);
% x = 1:temp;
% cftool(x,y);

%2d distance
data3 = data;
data3(:,3) = round(data(:,3));
CentroidData3 = CentroidData;
CentroidData3(:,3) = round(CentroidData(:,3));
slice = length(CentroidData3(:,3));
distance = ones(slice,1);
for i = 1:slice
    mytemp  = data3(data3(:,3) == CentroidData3(i,3),:);
    [D,I] = pdist2(mytemp,CentroidData3(i,:),'euclidean','Smallest',1);% I is indice position of vessel
    if isempty(D)
        distance(i,1) = 0; 
    else
        distance(i,1) = D;
    end
end
distance2d = mean(distance);
figure;hist(distance);
xlswrite('cvdistance2d.xlsx',distance);