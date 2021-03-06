% example.m is the main file
% the function canny in BloodVessel.m can't work under matlab version 2013a
% in the selection part, some hidden tiff files may cause error, so delete those hidden files

%% Processing of blood vessel
Crop = TiffInput('all');
num_hist = 10; % the slice for histmatch
x = 9;
outHist = HistMatch(Crop,num_hist);figure;imshow(outHist(:,:,x),[])
Col = ColumnMatch(outHist);figure;imshow(Col(:,:,x),[])
filter_size =5; % the size of filer in the preprosessing to denoise
filter_num =1; % how many times the filter is applied
bi_threshold = 0.1; %the threshhold of binarization, larger means fewer area left
Bi = MeanBi(Col,bi_threshold,filter_num,filter_size);figure;imshow(Bi(:,:,x),[])

% vessel = logical(Bi);

% simplify preprocessing for large dataset
BiVessel = bwareaopen(Bi,40,8);
se = strel('disk',7);
I = imdilate(BiVessel,se);
vessel = imerode(I,se);figure;imshow(vessel(:,:,x),[])

% difficult pictures
thresh_canny = [0.1 0.4]; %lower than low threshold means not edge, higher than high threshold means edge
strel_size = 7; % morphology element size
vessel = BloodVessel(Bi,thresh_canny,strel_size);figure;imshow(vessel(:,:,x),[])

save('vessel.mat','vessel')
[vPrecison,vRecall,vFmeasure] = AreaCoincidence(manualvessel48,vessel); 
bin = 60; % display parameter
mydisplay(Crop,bin);
mydisplay(outHist,bin);
mydisplay(Col,bin);

save_nii(make_nii(uint16(vessel)),'vessel.nii');  %change 3d mat data to nii
save_nii(make_nii(uint16(Crop)),'vesselCrop.nii');
%% computing
%tracing is plug-in --> neuron tracing --> Vaa3D neuron2 --> Vaa3D neuron2 app1
data = CombineVessel(vessel1, vessel2, cell);

% vessel volume
volper = VolPer(vessel); % volume percentage

load('C:\Users\Administrator\CloudStation\Vessel\vessel_1024x1024_0.78umx0.78umx2um\vessel.mat')
% expand and change
x = 0.78;
z = 2;
h = z/x;
squeeze = floor(h)/h;
real = expand(vessel,h);
%TiffChange(real,'vessel.tif'); %change 3d mat data to tiff file

sample = vessel;
% vessel
[length, dia] = lenAnddia('vessel.tif_x323_y10_z28_app2.swc',squeeze);
realDiaAverage = x*sqrt(sum(length.*(dia.^2))/sum(length));
LenVol = x*sum(length)*10^(-6)/(size(sample,1)*size(sample,2)*size(sample,3)*x^2*z*10^(-9));
percentage = sum((pi/4)*length.*(dia).^2)/(size(real,1)*size(real,2)*size(real,3)/(squeeze^3));%recheck the volume percentage

%micro vessel
micro = find(dia(:,1)<6/x);
MicroDiaAve =  x*sqrt(sum(length(micro).*(dia(micro).^2))/sum(length(micro)));
MicroDensity = x*sum(length(micro))*10^(-6)/(size(sample,1)*size(sample,2)*size(sample,3)*x^2*z*10^(-9));
MicroVolume = sum((pi/4)*length(micro).*(dia(micro)).^2)/(size(real,1)*size(real,2)*size(real,3)/(squeeze^3));

%vessel histogram
matHist = ones(12,2);
for i = 1:12
    if i ==12
        matHist(i,2) = x*sum(length(find(dia(:,1)> 22 )))*10^(-6)/(size(sample,1)*size(sample,2)*size(sample,3)*x^2*z*10^(-9));
    else
        low = 2*i-2;
        high = 2*i;
        matHist(i,2) = x*sum(length(find(dia(:,1)< high &dia(:,1)> low )))*10^(-6)/(size(sample,1)*size(sample,2)*size(sample,3)*x^2*z*10^(-9));
    end
    matHist(i,1) = 2*i-2;
end
xlswrite('matHist2.xlsx',matHist);

% cell vessel
h = 3; % the length of z axis, attention! z/x
[distance2d, distance3d]= CellDensity('vessel1.tif_x51_y432_z57_app2.swc',cell,h); %calculate the cell density

% manual 
Crop2 = fliplr(rot90(Crop)); % to change the direction of nii file
save_nii(make_nii(uint16(Crop)),'vesselCrop.nii');
temp = load_nii('ManualCell.nii');ManualCell = temp.img;

%need to fix
dia = diameter('vessel1.tif_x51_y432_z57_app2.swc','vessel2.tif_x3_y0_z14_app2.swc',vessel,h); % average diameter of vessel
diaHist = DiameterHistogram('vessel1.tif_x50_y436_z57_app1.swc','vessel2.tif_x417_y152_z2_app1.swc');