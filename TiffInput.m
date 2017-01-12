% input tiff, choose one of the tif pictures  
function [Crop, Bi] = TiffInput(num_hist,bi_threshold,filter_num,filter_size,bin)
tic
[~,PathName] = uigetfile('*.tif','Select the file');
Files = dir(fullfile(PathName,'*.tif'));
place = [PathName,Files(1).name];
tif = imread(place); % z = 156 slices, x = 437 or tif(:,1,1), y = 1379 or tif(1,:,1)
Data = ones(length(tif(:,1,1)),length(tif(1,:,1)),length(Files(:,1)));
for k = 1:length(Files(:,1))
    place = [PathName,Files(k,1).name];
    tif = imread(place);
    Data(:,:,k) = rgb2gray(tif);
end
Crop = crop(Data);
mydisplay(Crop,bin);
outHist = HistMatch(Crop,num_hist);
mydisplay(outHist,bin);
Col = ColumnMatch(outHist);
mydisplay(Col,bin);
Bi = MeanBi(Col,bi_threshold,filter_num,filter_size);
toc
