function Col = ColumnMatch(outHist)
% Match Columns to adjust the images
Col = outHist;
for j = 1:length(outHist(1,1,:))
    Cell = outHist(:,:,j);
    curve = mean(Cell);
    total = mean(curve);
    newCell = Cell;
    for i = 1 : length(Cell(1,:))
        newCell(:,i) = total*Cell(:,i)/curve(i);
    end
    Col(:,:,j) = newCell;
end
