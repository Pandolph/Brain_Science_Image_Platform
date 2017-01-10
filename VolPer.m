function volper = VolPer(vessel)
% compute the volume percentage
volper = length(find(vessel))/(length(vessel(1,1,:))*length(vessel(1,:,1))*length(vessel(:,1,1)));
volmat = ones(length(vessel(1,1,:)),1);
for i = 1 : length(vessel(1,1,:))
    volmat(i,1) = length(find(vessel(:,:,i)))/(length(vessel(1,:,1))*length(vessel(:,1,1)));
end
figure;plot(volmat);
