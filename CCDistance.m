function ccdistance = CCDistance(cell, x, z)
% expand and change

h = z/x;
squeeze = floor(h)/h;
cell = expand(cell,h);
Centroid = CentroidDetec(cell);
Centroid = Centroid/squeeze;
slice = length(Centroid(:,3));
distance = ones(2,slice);
for i = 1:slice
    temp = Centroid;
    point  = Centroid(i,:);
    temp(i,:) = [];
    [D,I] = pdist2(temp,point,'euclidean','Smallest',1);% I is indice position of vessel
    distance(1,i) = D;
    distance(2,i) = temp(I,3);
end
distance = distance';
xlswrite('ccdistance.xlsx',sortrows(distance,2));
ccdistance= mean(distance,1);
ccdistance = ccdistance(1);
%figure;hist(distance);
