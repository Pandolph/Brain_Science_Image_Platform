function [train_data, train_labels] = Pychange(imsize,order,str1,str2)
% image size must be odd
temp = load_nii(str1);
CellCrop = temp.img;
length = size(CellCrop,1)*size(CellCrop,2);
result = zeros(length,imsize,imsize);
temp2 = zeros(size(CellCrop,1)+imsize-1,size(CellCrop,2)+imsize-1);
start = (imsize+1)/2;
x = size(CellCrop,1)+(imsize-1)/2;
y = size(CellCrop,2)+(imsize-1)/2;
temp2(start:x, start:y) = CellCrop(:,:,order);
result_rotate = permute(result,[2 3 1]);
for i = 1:size(CellCrop,2) % row first ап
    for j =1:size(CellCrop,1)
        result_rotate(:,:,size(CellCrop,1)*(i-1)+j) =  temp2(j:j+imsize-1,i:i+imsize-1);
    end
end
train_data = permute(result_rotate,[3 1 2]);

temp = load_nii(str2);
ManualCell = temp.img;
first = ManualCell(:,:,order);
train_labels = first(:);


% [train_data, train_labels] = Pychange(27,1,'CellCrop.nii','ManualCell.nii');
% [test_data, test_labels] = Pychange(27,2,'CellCrop.nii','ManualCell.nii');
% test_data(10001:end,:,:) = [];
% test_labels(10001:end,:,:) = [];
% save('tf.mat','-v7.3')