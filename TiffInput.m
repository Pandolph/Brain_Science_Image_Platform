function Crop = TiffInput(channel)
% input tiff, choose one of the tif pictures  
%channel = 'all', 'part', '1', '2', '3'
[~,PathName] = uigetfile('*.tif','Select the file');
if strcmp(channel, 'all')
    Files = dir(fullfile(PathName,'*.tif'));
elseif strcmp(channel,  'part')
    Files1 = dir(fullfile(PathName,['*','.tif']));
    prompt = {'Start','End'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'1','100'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    Files = Files1([str2num(answer{1,1}):str2num(answer{2,1})],1);
else
    Files = dir(fullfile(PathName,['*',channel,'.tif']));
end
place = [PathName,Files(1).name];
tif = imread(place); % z = 156 slices, x = 437 or tif(:,1,1), y = 1379 or tif(1,:,1)
sliceSize = length(Files(:,1));
Data = ones(length(tif(:,1,1)),length(tif(1,:,1)),sliceSize);
for k = 1:sliceSize
    place = [PathName,Files(k,1).name];
    tif = imread(place);
    Data(:,:,k) = tif(:,:,find(mean(mean(tif,1),2)));
end
Crop = crop(Data);
