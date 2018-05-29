function TiffChange(stack,name)
%warning: it will change the file to unit8, which means the largest num is
%255, num larger than 255 will become 255 automatically
%stack = data;
% for i = 1:size(stack,3)
%     tempMin = min(min(data(:,:,i)));
%     tempMax = max(max(data(:,:,i)));
%     stack(:,:,i) = data(:,:,i)/max(max());
% end
imwrite(stack(:,:,1), name)
for k = 2:size(stack,3)    
    imwrite(stack(:,:,k), name, 'writemode', 'append');
end




