function Crop = CellMinus(Crop,m)

Crop1 = Crop(:,:,1:2:size(Crop,3));
Crop2 = Crop(:,:,2:2:size(Crop,3));

Crop3 = Crop2 - Crop1/m;

% for i = 1:size(Crop3,3)
% 
% end

Crop = round(Crop3 - min(min(min(Crop3))));



