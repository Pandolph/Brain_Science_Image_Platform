%crop 
function Crop = crop(Data)
Crop = Data;
Crop(:,1,:) =[];
Crop(:,end-3:end,:) =[];
