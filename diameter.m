function dia = diameter(vessel1,vessel2,vessel,h)
% compute the length and the volume of vessel, then get the diameter
temp = load_v3d_swc_file(vessel1);
k1 = ones(length(temp(:,1))-1,1);
for i = 1 : length(temp(:,1))-1
    k1(i,1) = sqrt((temp(i+1,3)-temp(temp(i+1,7),3))^2 + (temp(i+1,4)-temp(temp(i+1,7),4))^2 + ((temp(i+1,5)-temp(temp(i+1,7),5))*h)^2);
end

temp = load_v3d_swc_file(vessel2);
k2 = ones(length(temp(:,1))-1,1);
for i = 1 : length(temp(:,1))-1
    k2(i,1) = sqrt((temp(i+1,3)-temp(temp(i+1,7),3))^2 + (temp(i+1,4)-temp(temp(i+1,7),4))^2 + ((temp(i+1,5)-temp(temp(i+1,7),5))*h)^2);
end

dia = sqrt(4*length(find(vessel))*h /((sum(k1)+sum(k2))*pi)); 