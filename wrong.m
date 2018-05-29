 
for i = 1 : size(Crop,3)   
    I(:,:,i) = medfilt2(Crop(:,:,i),[filter_size,filter_size]);    
end
figure;imshow(I(:,:,1),[])
for i = 1 : size(Crop,3)   
    I(:,:,i) = medfilt2(Crop(:,:,i),[filter_size,filter_size]);    
end
figure;imshow(I(:,:,1),[])

for k = 1:size(I,3)    
    imwrite(I(:,:,k), ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end
for k = 1:size(I,3)    
    imwrite(I(:,:,k-2:k), ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end
下标索引必须为正整数类型或逻辑类型。
 
for k = 5  
    imwrite(I(:,:,k-2:k), ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end
Crop = TiffInput('2');
20  sliceSize = length(Files(:,1));
figure;imshow(tif(:,:,1),[])
figure;imshow(tif(:,:,2),[])
figure;imshow(tif(:,:,3),[])
temp = I(:,:,k);
temp = cat(1,temp,zeros(319,309,2));
错误使用 cat
串联的矩阵的维度不一致。
 
temp = cat(3,temp,zeros(319,309,2));
for k = 5
  
    imwrite(I(:,:,k-2:k), ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end
for k = 5
  temp = I(:,:,k);temp = cat(3,temp,zeros(319,309,2));
    imwrite(temp, ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end
for k = 1:size(I,3)  
  temp = I(:,:,k);temp = cat(3,temp,zeros(319,309,2));
    imwrite(temp, ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end
Crop = TiffInput('2');
num_hist = 1; % the slice for histmatch
outHist = HistMatch(Crop,num_hist);figure;imshow(outHist(:,:,1),[])
%Col = ColumnMatch(outHist);
filter_size =5; % the size of filer in the preprosessing to denoise
filter_num =1; % how many times the filter is applied
bi_threshold = 0.20; %the threshhold of binarization, larger means fewer area left
Bi = MeanBi(outHist,bi_threshold,filter_num,filter_size);figure;imshow(Bi(:,:,1),[])
BiVessel = bwareaopen(Bi,40,8);
se = strel('disk',4);
I = imdilate(BiVessel,se);
vessel = imerode(I,se);figure;imshow(vessel(:,:,end),[])
I = vessel;
for k = 1:size(I,3)  
  temp = I(:,:,k);temp = cat(3,temp,zeros(319,309,2));
    imwrite(temp, ['2vo1weekcd68iba1mbp002_cropz',num2str(k),'c2.tif'])
end