function VesselCenter = CombineVessel(vessel1, vessel2, template)
[~, data1]=VesselLineRead(vessel1);
[~, data2]=VesselLineRead(vessel2);
cell = template;
data2(:,1) = data2(:,1) + round(size(cell,2)/2);
VesselCenter = cat(1,data1,data2);



% switch nargin
%     case 2
%         c = a + b;
%     case 1
%         c = a + a;
%     otherwise
%         c = 0;
% end