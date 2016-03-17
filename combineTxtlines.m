% this file use pos2.txt,then append at the end of each class.txt,and then
% unique the class.txt
clc,clear;
bpath='H:\Resource\Cnds\VOC\ImageSets\Main\';
txtnames=dir([bpath '*.txt']);
fida=fopen([bpath 'pos2.txt'],'r');
dataA=fread(fida);

for i=1:length(txtnames)
    if ~strcmp(txtnames(i).name,'pos2.txt')
		fidb=fopen([bpath txtnames(i).name],'a');
		fwrite(fidb,dataA);
		fclose(fidb);
		% combine the same file
		fidc=fopen([bpath txtnames(i).name],'r');
		linestruct=struct();
		while ~feof(fidc)
			line=fgetl(fidc);
			S = regexp(line, ' ', 'split');
			frameid=char(S{1});frameval=char(S{2});
			if ~isfield(linestruct, frameid)
				linestruct.(frameid)=frameval;
			end
		end
		fclose(fidc);
		fidd=fopen([bpath txtnames(i).name],'w');
		fields=fieldnames(linestruct);
		for k=1:length(fields)
%             fieldval=linestruct.(fields{k});
			newline=[fields{k} ' ' linestruct.(fields{k})];
			fprintf(fidd, '%s\n', newline);
		end
		fclose(fidd);
    end
    if rem(i,1) == 0
        disp([' ' num2str(i)]);
    end
end
fclose(fida);
delete([bpath 'pos.txt'],[bpath 'pos2.txt']);