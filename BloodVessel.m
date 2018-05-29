function BiVessel = BloodVessel(data,thresh,size)

%thresh = [0.01 0.5];
%size = 6;
%figure;imshow(data(:,:,1),[]);
%lower than low threshold means not edge, higher than high threshold means edge
e = canny(data, [1 1 0], 'TMethod', 'relMax', 'TValue', thresh, 'SubPixel', true);
%plot3(e.subpix{1}(e.edge), e.subpix{2}(e.edge), e.subpix{3}(e.edge), '.');
%figure;imshow(e.edge(:,:,1),[]);
%imshow(e.subpix{1}(:,:,50));
shape = 'disk';
se = strel(shape,size);
I = imdilate(e.edge,se);
se = strel(shape,size);
BiVessel = imerode(I,se);
%figure;imshow(BiVessel(:,:,1));
