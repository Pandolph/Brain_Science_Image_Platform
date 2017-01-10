function per = percentage(manual,vessel)
% compute the binary per
per = size(intersect(find(manual),find(vessel)))/size(find(manual));
permat = ones(1,size(vessel,3));
for i = 1:size(vessel,3)
    permat(i) = size(intersect(find(manual(:,:,i)),find(vessel(:,:,i))))/size(find(manual(:,:,i)));
end
figure;
plot(permat)