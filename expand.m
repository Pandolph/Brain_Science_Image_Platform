function [real,squeeze ]= expand(sample,h)
% expand the sample to real scale and squeeze means paramter
temp = ones(size(sample,1),size(sample,2),floor(h)*size(sample,3));
for i = 1:size(sample,3)
    temp(:,:,floor(h)*(i-1)+1:floor(h)*i) = repmat(sample(:,:,i),1,1,floor(h));
end
gap = h/(h-floor(h));
arrayx = round([1:floor(size(temp,1)/gap)]*gap);
arrayy = round([1:floor(size(temp,2)/gap)]*gap);
temp(arrayx,:,:) = [];
temp(:,arrayy,:) = [];
real = temp;
squeeze = floor(h)/h;