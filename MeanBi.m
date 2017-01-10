function Bi = MeanBi(Data,thresh,num,filter_size)
% apply mean operation and then binarization
%thresh = 0.2;  % larger means less choosed region
%num = 3;

tic
Bi = Data;
for i = 1 : size(Data,3)   
    I = Data(:,:,i)/max(max(Data(:,:,i)));    
    for j = 1:num
    I = medfilt2(I,[filter_size,filter_size]);    
    end    
    I = im2bw(I,thresh);
    Bi(:,:,i) = I;
end
toc