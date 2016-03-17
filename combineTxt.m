% this matlab file,generate all the frameid that contain object,and unique
% the frameid,output to pos2.txt;to be used for combineTxtlines.m.

clc,clear;
bpath='H:\Resource\Cnds\VOC\ImageSets\Main\';
%% this part first execute
txtnames=dir([bpath '*.txt']);
fida=fopen([bpath 'pos.txt'],'a');%dui ying di yi ge for xun huan
for i=1:length(txtnames)
    if ~strcmp(txtnames(i).name,'pos.txt')
		fidb=fopen([bpath txtnames(i).name],'r');
        dataB=fread(fidb);
		fwrite(fida,dataB);
		fclose(fidb);
    end
    if rem(i,1) == 0
        disp([' ' num2str(i)]);
    end
end
fclose(fida);
%% this part second execute
        fida=fopen([bpath 'pos.txt'],'r');
		% combine the same file
		linestruct=struct();
        while ~feof(fida)
			line=fgetl(fida);
			S = regexp(line, ' ', 'split');
			frameid=char(S{1});%frameval=char(S{2});
			if ~isfield(linestruct, frameid)
				linestruct.(frameid)='-1';
			end
        end
        fclose(fida);
		fidd=fopen([bpath 'pos2.txt'],'w');
		fields=fieldnames(linestruct);
		for k=1:length(fields)
			newline=[fields{k} ' ' linestruct.(fields{k})];
			fprintf(fidd, '%s\n', newline);
		end
		fclose(fidd);