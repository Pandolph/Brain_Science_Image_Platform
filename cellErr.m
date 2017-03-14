function [cPrecison,cRecall,cFmeasure] = cellErr(manualcell,cell,distance)
mCentroid = CentroidDetec(manualcell);
cCentroid = CentroidDetec(cell);
temp = cCentroid;

for i = 1:length(mCentroid(:,1))
    [D,I] = pdist2(temp,mCentroid(i,:),'euclidean','Smallest',1);
    if D < distance
        temp(I,:) = [];
    end
end
coincide = length(cCentroid(:,1))-length(temp(:,1));
cPrecison = coincide/length(cCentroid(:,1));
cRecall = coincide/length(mCentroid(:,1));
cFmeasure = 2*cPrecison*cRecall/(cRecall+cPrecison);

% h = figure;
% scatter3(mCentroid(1:end,1),mCentroid(1:end,2),mCentroid(1:end,3),'MarkerFaceColor','blue');
% hold on 
% scatter3(cCentroid(1:end,1),cCentroid(1:end,2),cCentroid(1:end,3),'MarkerFaceColor','red');
% axis equal