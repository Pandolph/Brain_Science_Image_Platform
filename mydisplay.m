function mydisplay(Data, bin)

mat = ones(length(Data(1,1,:)),bin);
for i = 1:length(Data(1,1,:))
    slice = Data(:,:,i);
    slice = slice/max(slice(:));
    [counts,x] = imhist(slice,bin);
    mat(i,:) = counts;
end
%figure;imshow(log(mat));title('log,imshow');
figure;imagesc(log(mat));title('log,imagesc');
