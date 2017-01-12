function Crop = crop(Data)
%crop 
Crop = Data;
temp = [];
for i = 1:length(Crop(:,1,1))
    if ~sum(any(Crop(i,:,:)))
        temp = [temp i];
    end
end
Crop(temp,:,:) =[];
temp = [];
for i = 1:length(Crop(1,:,1))
    if ~sum(any(Crop(:,i,:)))
        temp = [temp i];
    end
end
Crop(:,temp,:) =[];
