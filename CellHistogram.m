function cellHist = CellHistogram(cell)
Centroid = CentroidDetec(cell);
figure;cellHist = hist(Centroid(:,3),round(max(Centroid(:,3)))+1);
figure; plot(cellHist);
xlswrite('cellHist.xlsx',cellHist);

