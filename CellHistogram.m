function cellHist = CellHistogram(cell,x,z)
% 30nm in axis z is one section 
Centroid = CentroidDetec(cell);
Centroid(:,3) = z*Centroid(:,3);
temp = ceil(max(Centroid(:,3)));
cellHist = hist(Centroid(:,3),temp);
area = size(cell,1)*size(cell,2)*x^2;
cellHist = 10^9*cellHist/area; % the number of cells in mm^3
xlswrite('cellHist.xlsx',cellHist');