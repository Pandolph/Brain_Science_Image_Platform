function [vPrecison,vRecall,vFmeasure] = AreaCoincidence(manualvessel48,vessel)
temp = size(intersect(find(manualvessel48),find(vessel)));
vRecall = temp/size(find(manualvessel48));
vPrecison = temp/size(find(vessel));
vFmeasure = 2*vPrecison*vRecall/(vRecall+vPrecison);
 
 