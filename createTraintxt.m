% use createTrain_test.m to replace this function
% create train.txt
clc,clear
vocAnnottpath='H:\Resource\Cnds\VOC\Annotations\';
vocTxtpath='H:\Resource\Cnds\VOC\ImageSets\Main\';
xmlnames=dir([vocAnnottpath '*.xml']);
fid=fopen([vocTxtpath 'train.txt'],'a');
for i=1:length(xmlnames)
    xmlname=xmlnames(i).name;xmlname=xmlname(1:end-4);
    fprintf(fid,'%s\n',xmlname);
end
fclose(fid);
