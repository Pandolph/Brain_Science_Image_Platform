%% myelin 
Crop = TiffInput(1); % 0 means all file, 1 is channel1, 2 is channel2, and so on 
num_hist = 30; % choose the cleareat one
outHist = HistMatch(Crop,num_hist);
%Col = ColumnMatch(outHist);
figure;imshow(outHist(:,:,1),[])
filter_size =2;
filter_num =6;
bi_threshold = 0.15; % most important, larger means fewer left
Bi = MeanBi(outHist,bi_threshold,filter_num,filter_size);
figure;imshow(Bi(:,:,1),[])

se = strel('disk',6);
temp = imerode(Bi,se);
myelin = imdilate(temp,se);

% area_size = 0; % delete the area whose size is smaller than area_size
% se_size = 2;
% myelintemp = Cell(Bi,area_size,se_size);
% figure;imshow(myelintemp(:,:,300),[])
% se = strel('disk',1);
% temp = imdilate(myelintemp,se);
% se = strel('disk',4);
% temp = imerode(temp,se);
% se = strel('disk',2);
% myelin = imdilate(temp,se);

figure;imshow(myelin(:,:,1),[])
figure;imshow(myelin(:,:,round(end/2)),[])
figure;imshow(myelin(:,:,end),[])

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
bi_threshold = 0.6; % most important, larger means fewer left
Bi = MeanBi(outHist,bi_threshold,filter_num,filter_size);
figure;imshow(Bi(:,:,1));

area_size = 20; % delete the area whose size is smaller than area_size
se_size = 3;
cell = Cell(Bi,area_size,se_size);
figure;imshow(cell(:,:,1))
figure;imshow(Crop(:,:,end-10),[])
figure;imshow(Bi(:,:,end-10),[])
figure;imshow(cell(:,:,end-10),[])

save('cell.mat','cell');
save_nii(make_nii(uint16(cell)),'cell.nii');

distance = 10; % the diameter of cell is around 10 pixels
temp = load_nii('manualcell432.nii');manualcell432 = temp.img;
manualcell432_21 = manualcell432(:,:,1:56);
figure;imshow(manualcell432_21(:,:,10),[]);
[cPrecison,cRecall,cFmeasure] = cellErr(manualcell432_21,cell,distance);

bin = 80; % display parameter
mydisplay(Crop,bin);
mydisplay(outHist,bin);
mydisplay(Col,bin);

%% computation

place = 'C:\Users\Administrator\CloudStation\celldata\被选中重复备份的6组cell&myelin\2vo6weeks No36 myelin and microglia each channel_512512335_1.01x1.01x1.2';
load([place,'\cell.mat'])
load([place,'\myelin.mat'])

% cell density
z = 1.7;
x = 1.01;
cellHist = CellHistogram(cell,x,z);

% myelin & cell distance
zxis = z;
[cmdistance3d,cmdistance2d] = CMDistance(cell, myelin,x,zxis);

% cell distance
ccdistance = CCDistance(cell, x, z);
