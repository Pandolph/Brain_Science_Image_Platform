function [length, dia] = lenAnddia(vessel,squeeze)
% vessel length
temp2 = load_v3d_swc_file(vessel);
temp3 = cat(2,temp2,ones(size(temp2,1),1));

for i = 1:size(temp3,1)
    if i == 1
        temp3(i,8) = 0;
    else
    node = temp3(i,7);
    temp3(i,8) = sqrt((temp3(i,3)-temp3(node,3))^2+(temp3(i,4)-temp3(node,4))^2+(temp3(i,5)-temp3(node,5))^2);
    end
end
length = temp3(:,8)/squeeze;
dia = 2*temp3(:,6)/squeeze;