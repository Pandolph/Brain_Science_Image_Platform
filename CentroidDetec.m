function CentroidData = CentroidDetec(cell)
cc=bwconncomp(cell); 
kk = struct2cell(regionprops(cc,'Centroid'));
kk = kk';
CentroidData=cell2mat(kk);
