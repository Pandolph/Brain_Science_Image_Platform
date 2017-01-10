function outHist = HistMatch(Crop,num)
% RawData is the data and num is the matched group
% Because the maxmum of all slices is almost the same, so we use im2 = second/max(second(:))

RawData = Crop;
outHist = ones(length(RawData(:,1,1)),length(RawData(1,:,1)),length(RawData(1,1,:)));
second = RawData(:,:,num);
maxs = max(second(:));
im2 = second/maxs;
hist2 = imhist(im2,maxs);
cdf2 = cumsum(hist2) / numel(im2);
for i = 1:length(RawData(1,1,:))
    first = RawData(:,:,i);
    maxf = max(first(:));
    im1 = first/maxf;
    hist1 = imhist(im1,maxf); %// Compute histograms
    cdf1 = cumsum(hist1) / numel(im1); %// Compute CDFs
    newMax = max(maxf, maxs);
    M = zeros(newMax,1); %// Store mapping - Cast to uint8 to respect data type
    %// Compute the mapping
    for idx = 1 : maxf
        [~,ind] = min(abs(cdf1(idx) - cdf2)); % idx of cdf1 and ind of cdf2
        M(idx) = ind;
    end
    %// Now apply the mapping to get first image to make
    %// the image look like the distribution of the second image
    %first means changing first to second, out is the first data in second histogram
    out = M(first); % pay attention to this kind of transformation! excellent!
    outHist(:,:,i) = out;
    
    
end
