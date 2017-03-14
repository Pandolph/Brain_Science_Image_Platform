% example.m is the main file
% the function canny in BloodVessel.m can't work under matlab version 2013a
% in the selection part, some hidden tiff files may cause error, so delete those hidden files
% one folder shall contain only one kind of tissue pictures
% the y aixs of vessel input in vaa3d shall be no more than 700

%% myelin 
Crop = TiffInput();
num_hist = 30;
outHist = HistMatch(Crop,num_hist);
Col = ColumnMatch(outHist);
filter_size =3;
filter_num =3;
bi_threshold = 0.2; % most important, larger means fewer left
Bi = MeanBi(Col,bi_threshold,filter_num,filter_size);
area_size = 0; % delete the area whose size is smaller than area_size
se_size = 5;
myelin = Cell(Bi,area_size,se_size);
se = strel('disk',5);
temp = imdilate(myelin,se);
se = strel('disk',15);
temp = imerode(temp,se);
se = strel('disk',8);
myelin = imdilate(temp,se);

i =2;
[mPrecison,mRecall,mFmeasure] = AreaCoincidence(manualmyelin(:,:,1:i),myelin(:,:,1:i)); 
figure;imshow(myelin(:,:,1),[])
figure;imshow(manualmyelin(:,:,1),[])

save_nii(make_nii(uint16(Crop)),['myelinCrop',date,num2str(size(myelin,1)),num2str(size(myelin,2)),num2str(size(myelin,3)),'.nii']);
save_nii(make_nii(uint16(myelin)),['myelin',date,num2str(size(myelin,1)),num2str(size(myelin,2)),num2str(size(myelin,3)),'.nii']);

%% Processing of blood vessel
load('manual48.mat')
Crop = TiffInput();
num_hist = 2; % the slice for histmatch
outHist = HistMatch(Crop,num_hist);
Col = ColumnMatch(outHist);
filter_size =3; % the size of filer in the preprosessing to denoise
filter_num =3; % how many times the filter is applied
bi_threshold = 0.3; %the threshhold of binarization, larger means fewer area left
Bi = MeanBi(Col,bi_threshold,filter_num,filter_size);
thresh_canny = [0.2 0.5]; %lower than low threshold means not edge, higher than high threshold means edge
strel_size = 5; % morphology element size
vessel = BloodVessel(Bi,thresh_canny,strel_size);
[vPrecison,vRecall,vFmeasure] = AreaCoincidence(manualvessel48,vessel); 
bin = 60; % display parameter
mydisplay(Crop,bin);
mydisplay(outHist,bin);
mydisplay(Col,bin);
save_nii(make_nii(uint16(vessel)),'vessel.nii');  %change 3d mat data to nii
save_nii(make_nii(uint16(Crop)),'vesselCrop.nii');

%% Processing of cell
load('manual48.mat')
Crop = TiffInput();
num_hist = 1;
outHist = HistMatch(Crop,num_hist);
Col = ColumnMatch(outHist);
figure;imshow(Col(:,:,1),[]);
filter_size =7;
filter_num =3;
bi_threshold = 0.40; % most important, larger means fewer left
Bi = MeanBi(Col,bi_threshold,filter_num,filter_size);
figure;imshow(Bi(:,:,10));
area_size = 290; % delete the area whose size is smaller than area_size
se_size = 3;
cell = Cell(Bi,area_size,se_size);
figure;imshow(cell(:,:,10));
distance = 10; % the diameter of cell is around 10 pixels
temp = load_nii('manualcell432.nii');manualcell432 = temp.img;
manualcell432_21 = manualcell432(:,:,1:56);
figure;imshow(manualcell432_21(:,:,10),[]);
[cPrecison,cRecall,cFmeasure] = cellErr(manualcell432_21,cell,distance);
bin = 60; % display parameter
mydisplay(Crop,bin);
mydisplay(outHist,bin);
mydisplay(Col,bin);
save_nii(make_nii(uint16(Crop)),'CellCrop.nii');
save_nii(make_nii(uint16(cell)),'cell.nii');

%% vaa3d
TiffChange(vessel(:,1:round(end/2),:),'vessel1.tif'); %change 3d mat data to tiff file
TiffChange(vessel(:,round(end/2)+1:end,:),'vessel2.tif');
TiffChange(manualvessel48(:,1:round(end/2),:),'manualvessel1.tif'); %change 3d mat data to tiff file
TiffChange(manualvessel48(:,round(end/2)+1:end,:),'manualvessel2.tif');
% plug-in --> neuron tracing --> Vaa3D neuron2 --> Vaa3D neuron2 app1
distance = 10;
[vPrecison2,vRecall2,vFmeasure2] = percentage('manualvessel1.tif_x84_y272_z5_app1.swc','manualvessel2.tif_x415_y285_z3_app1.swc',...
    'vessel1.tif_x473_y0_z29_app1.swc','vessel2.tif_x418_y153_z2_app1.swc',cell48,distance) % the coincide percentage

%% computation
% vessel
volper = VolPer(vessel); % volume percentage
dia = diameter('vessel1.tif_x51_y432_z57_app2.swc','vessel2.tif_x3_y0_z14_app2.swc',vessel,h); % average diameter of vessel
diaHist = DiameterHistogram('vessel1.tif_x50_y436_z57_app1.swc','vessel2.tif_x417_y152_z2_app1.swc');

% cell 
cellHist = CellHistogram(cell)

% cell vessel
h = 3; % the length of z axis, attention! z/x
[distance2d, distance3d]= CellDensity('vessel1.tif_x51_y432_z57_app2.swc','vessel2.tif_x3_y0_z14_app2.swc',...
    cell,h); %calculate the cell density

% cell myelin
[cmdistance3d,cmdistance2d] = CMDistance(cell, myelin)





% sample
len = 30;
x = size(Crop,1);
y = size(Crop,2);
z = size(Crop,3);
matR1 = zeros(len,len,len);
matR2 = zeros(len,len,len);
matA1 = Crop(round(x/4)-len/2:round(x/4)+len/2-1,round(y/4)-len/2:round(y/4)+len/2-1,round(z/4)-len/2:round(z/4)+len/2-1);
matA2 = Crop(x-round(x/4)-len/2:x-round(x/4)+len/2-1,y-round(y/4)-len/2:y-round(y/4)+len/2-1,z-round(z/4)-len/2:z-round(z/4)+len/2-1);
save_nii(make_nii(uint16(matR1)),'Bi.nii');
save_nii(make_nii(uint16(matR2)),'Bi.nii');
save_nii(make_nii(uint16(Crop)),'CellCropAll.nii');

%temp = load_nii('ManualCell.nii');ManualCell = temp.img;
