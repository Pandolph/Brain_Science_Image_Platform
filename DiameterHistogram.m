function diaHist = DiameterHistogram(vessel1,vessel2)

temp1 = load_v3d_swc_file(vessel1);
temp2 = load_v3d_swc_file(vessel2);
mat = 2*[temp1(:,6);temp2(:,6)];
diaHist = mean(mat);
figure;hist(mat);