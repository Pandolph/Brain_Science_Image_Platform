out = imread('/Users/pan/Desktop/SVM/SVM/test.tif');
m = medfilt2(rgb2gray(out),[5,5]);
imwrite(m,'/Users/pan/Desktop/SVM/SVM/m.tif')

% SVM
% Mat ForeImg = srcImg(Rect(256, 256, 30, 30));//2D, Rect(x,y,width,height)

myelin = imread('/Users/pan/Desktop/SVM/SVM/result.jpg');

close all
se = strel('disk',5);
temp = imerode(myelin,se);
se = strel('disk',1);
k = imdilate(temp,se);
figure;imshow(k);

figure;imshow(manualmyelin(:,:,1),[])
i =1;
[mPrecison,mRecall,mFmeasure] = AreaCoincidence(manualmyelin(:,:,1:i),k(:,:,1:i));
