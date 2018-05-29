place = '/Users/pan/Desktop';
manual = manualvessel48;
Crop = TiffInput(1);
dense = 46;
matsize = 256;
teststack = Crop(1:256,1:256,dense+1:dense+30);

mkdir([place,'/data/test']);
mkdir([place,'/data/train/image']);
mkdir([place,'/data/train/label']);

% reshape
sizex = fix(size(manual,1)/matsize);
sizey = fix(size(manual,2)/matsize);
trainmat = [];
manualmat = [];
for i = 1:sizex
    for j = 1:sizey
        trainmat = cat(3,trainmat,Crop((i-1)*matsize+1:i*matsize,(j-1)*matsize+1:j*matsize,1:dense));
        manualmat = cat(3,manualmat,manual((i-1)*matsize+1:i*matsize,(j-1)*matsize+1:j*matsize,1:dense));
    end
end
num = size(manualmat,3);

% from 256 to 512
trainmatEnlarge = ones(512,512,size(trainmat,3));
teststackEnlarge = ones(512,512,size(teststack,3));
manualmatEnlarge = ones(512,512,size(manualmat,3));

for j = 1: size(trainmat,3)
    A=trainmat(:,:,j);
    b=ones(2);
    [m,n]=size(A);
    B=num2cell(A);
    C=cell(m*n,1);
    for i=1:m*n
        C{i}=B{i}*b;
    end
    trainmatEnlarge(:,:,j) = cell2mat(reshape(C,m,n)); 
end

for j = 1: size(manualmat,3)
    A=manualmat(:,:,j);
    b=ones(2);
    [m,n]=size(A);
    B=num2cell(double(A));
    C=cell(m*n,1);
    for i=1:m*n
        C{i}=B{i}*b;
    end
    manualmatEnlarge(:,:,j) = cell2mat(reshape(C,m,n)); 
end

for j = 1: size(teststack,3)
    A=teststack(:,:,j);
    b=ones(2);
    [m,n]=size(A);
    B=num2cell(A);
    C=cell(m*n,1);
    for i=1:m*n
        C{i}=B{i}*b;
    end
    teststackEnlarge(:,:,j) = cell2mat(reshape(C,m,n)); 
end
trainmat = trainmatEnlarge ;
teststack = teststackEnlarge;
manualmat = manualmatEnlarge;

% input the train image files
stack = trainmat;
name = [place,'/data/train/image/'];
for j = 1:num 
    maxs = reshape(max(max(stack,[],2),[],1),[1,num]);
    temp = uint8(256*stack(:,:,j)/maxs(j));
    imwrite(temp, [name,num2str(j),'.tif']);
end

% input the test image files
stack = teststack;
name = [place,'/data/test/'];
for j = 1:size(stack,3) 
    maxs = reshape(max(max(stack,[],2),[],1),[1,size(stack,3)]);
    temp = uint8(256*stack(:,:,j)/maxs(j));
    imwrite(temp, [name,num2str(j),'.tif']);
end

% change manual to i slices single 256*256 tiff
stack = uint8(255*manualmat);
name = [place,'/data/train/label/'];
for j = 1:num 
    imwrite(stack(:,:,j), [name,num2str(j),'.tif']);
end

% after unet
k = imread('/Users/pan/Desktop/unet/results/0.jpg');
for i = 1:256
    for j = 1:256
        k2(i,j) = k(2*i,2*j);
    end
end
figure;imshow(k2);