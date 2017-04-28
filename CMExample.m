%% myelin 
Crop = TiffInput(1); % 0 means all file, 1 is channel, 2 is channel2, and so on 
num_hist = 30; % choose the cleareat one
outHist = HistMatch(Crop,num_hist);
Col = ColumnMatch(outHist);
figure;imshow(Crop(:,:,1),[])
filter_size =3;
filter_num =3;
bi_threshold = 0.3; % most important, larger means fewer left
Bi = MeanBi(Col,bi_threshold,filter_num,filter_size);
figure;imshow(Bi(:,:,1),[])
area_size = 0; % delete the area whose size is smaller than area_size
se_size = 5;
myelintemp = Cell(Bi,area_size,se_size);
figure;imshow(myelintemp(:,:,1),[])
se = strel('disk',8);
temp = imdilate(myelintemp,se);
se = strel('disk',15);
temp = imerode(temp,se);
se = strel('disk',8);
myelin = imdilate(temp,se);
figure;imshow(myelin(:,:,1),[])
figure;imshow(myelin(:,:,round(end/2)),[])
figure;imshow(myelin(:,:,end),[])
figure;imshow(myelin(:,:,1),[])

i =2;[mPrecison,mRecall,mFmeasure] = AreaCoincidence(manualmyelin(:,:,1:i),myelin(:,:,1:i));
save_nii(make_nii(uint16(Crop)),['myelinCrop',date,num2str(size(myelin,1)),num2str(size(myelin,2)),num2str(size(myelin,3)),'.nii']);
save_nii(make_nii(uint16(myelin)),['myelin',date,num2str(size(myelin,1)),num2str(size(myelin,2)),num2str(size(myelin,3)),'.nii']);

%% Processing of cell
Crop = TiffInput(2);
figure;imshow(Crop(:,:,1),[]);

Crop = TiffInput(0);
Crop = CellMinus(Crop,2.5);

num_hist = 50;
outHist = HistMatch(Crop,num_hist);
%Col = ColumnMatch(outHist);
figure;imshow(outHist(:,:,1),[]);

filter_size =3;
filter_num =3;
bi_threshold = 0.45; % most important, larger means fewer left
Bi = MeanBi(outHist,bi_threshold,filter_num,filter_size);
figure;imshow(Bi(:,:,1));

area_size = 20; % delete the area whose size is smaller than area_size
se_size = 3;
cell = Cell(Bi,area_size,se_size);
figure;imshow(cell(:,:,1))
figure;imshow(Crop(:,:,200),[])
figure;imshow(Bi(:,:,200),[])
figure;imshow(cell(:,:,200),[])

save('cell.mat','cell');
save_nii(make_nii(uint16(cell)),'cell.nii');
cellHist = CellHistogram(cell);
[cmdistance3d,cmdistance2d] = CMDistance(cell, myelin);

distance = 10; % the diameter of cell is around 10 pixels
temp = load_nii('manualcell432.nii');manualcell432 = temp.img;
manualcell432_21 = manualcell432(:,:,1:56);
figure;imshow(manualcell432_21(:,:,10),[]);
[cPrecison,cRecall,cFmeasure] = cellErr(manualcell432_21,cell,distance);

bin = 80; % display parameter
mydisplay(Crop,bin);
mydisplay(outHist,bin);
mydisplay(Col,bin);