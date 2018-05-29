api_url = 'https://api.wmcloud.com/data/v1';
%将your token替换为在网站中获取的token
header = http_createHeader('Authorization','Bearer d0daf777cfe5a018fb605edbfb5e12572e35405c4fc1fbac8a5a2a5277caffa2');
csvdata = urlread2(sprintf('%s/api/market/getMktEqud.csv?field=&beginDate=20150101&endDate=&secID=&ticker=000001&tradeDate=',api_url),'','',header); %csv file
disp(csvdata)
%将数据保存在csv文件中
file=fopen('getThemeThemes.csv','w');
fprintf(file,'%s',csvdata);
fclose(file);