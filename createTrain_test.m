% create train and test text for Pascal VOC dataset
clc,clear
vocAnnottpath='H:\Resource\Cnds\VOC\Annotations\';
vocTxtpath='H:\Resource\Cnds\VOC\ImageSets\Main\';
xmlnames=dir([vocAnnottpath '*.xml']);
fid=fopen([vocTxtpath 'train.txt'],'a');
fid2=fopen([vocTxtpath 'test.txt'],'a');
for i=1:length(xmlnames)
    xmlname=xmlnames(i).name;xmlname=xmlname(1:end-4);
    prefix_xml_name=xmlname(4:end-6);prefix_int=str2num(prefix_xml_name);
    if prefix_int==5||prefix_int==6||prefix_int==7||prefix_int==8||prefix_int==9
        % save in test
        fprintf(fid2,'%s\n',xmlname);
    else
        % save in train
        fprintf(fid,'%s\n',xmlname);
    end
end
fclose(fid2);
fclose(fid);
