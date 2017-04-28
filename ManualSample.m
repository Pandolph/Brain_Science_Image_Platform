% small sample for manual verify
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