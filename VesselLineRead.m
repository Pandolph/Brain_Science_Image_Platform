function [num, data]=VesselLineRead(name)
% name = 'stack1.tif_x934_y242_z151_app2.swc'
temp = load_v3d_swc_file(name);
num = length(temp);
data = temp(:,3:5);

