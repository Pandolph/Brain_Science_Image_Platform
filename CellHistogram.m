function cellHist = CellHistogram(cell,x,y,z,num)
Centroid = CentroidDetec(cell);
temp = round(max(Centroid(:,3))/2)+1;
cellHist = hist(Centroid(:,3),temp);

%still need the x y z data to improve

xlswrite('cellHist.xlsx',cellHist);