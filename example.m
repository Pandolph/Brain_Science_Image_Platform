% example.m is the main file
% the function canny in BloodVessel.m can't work under version 2013a

%% Processing of blood vessel
num_hist = 30; % the slice for histmatch
filter_size =3; % the size of filer in the preprosessing to denoise
filter_num =3; % how many times the filter is applied
bi_threshold = 0.2; %the threshhold of binarization, larger means fewer area left
thresh_canny = [0.01 0.5]; %lower than low threshold means not edge, higher than high threshold means edge
strel_size = 6; % morphology element size
[Crop, Bi] = TiffInput(num_hist,bi_threshold,filter_num,filter_size); 
vessel = BloodVessel(Bi,thresh_canny,strel_size);
TiffChange(vessel(:,1:round(end/2),:),'vessel1.tif'); %change 3d mat data to tiff file
TiffChange(vessel(:,round(end/2)+1:end,:),'vessel2.tif'); 
save_nii(make_nii(uint16(vessel)),'vessel.nii');  %change 3d mat data to nii
save_nii(make_nii(uint16(Crop)),'vesselCrop.nii'); 
% Vaa3D, tif file input--advanced--3D tracing--Vaa3D neuron2 auto tracing--set -1 autotracing

%% Processing of cell
num_hist = 2; 
filter_size =3;
filter_num =3;
bi_threshold = 0.4; 
area_size = 180; % delete the area whose size is smaller than area_size
[Crop, Bi] = TiffInput(num_hist,bi_threshold,filter_num,filter_size);
cell = Cell(Bi,area_size);
save_nii(make_nii(uint16(Crop)),'CellCrop.nii');
save_nii(make_nii(uint16(cell)),'cell.nii'); 

%% computation
h = 1.6; % the length of z axis, attention!
distance = CellDensity('vessel1.tif_x48_y0_z57_app2.swc','vessel2.tif_x419_y282_z2_app2.swc', cell,h); %calculate the cell density
perv = percentage(manualvessel48,vessel48); % the conincide percentage
perc = percentage(manualcell48,cell48);
volper = VolPer(vessel); % volume percentage

% C = cat(3, Manual(:,:,1:48), vessel(:,:,49:end));
% temp = load_nii('cell.nii');cell = temp.img;