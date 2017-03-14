function [vPrecison2,vRecall2,vFmeasure2] = percentage(manual1,manual2,vessel1,vessel2,cell,distance)

datav = CombineVessel(vessel1, vessel2, cell);
datam = CombineVessel(manual1, manual2, cell);

[D,I] = pdist2(datam,datav,'euclidean','Smallest',1);% I is indice position of vessel
vPrecison2 = size(find(D<distance))/size(D);
vRecall2 = size(find(D<distance))/size(datam(:,1));
vFmeasure2 = 2*vPrecison2*vRecall2/(vPrecison2*vRecall2);