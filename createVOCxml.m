% 根据txt中的内容提取正样本，并生成对应的xml以及图片，改变writeMytxt中的label=‘-1’,同时修改annotation注释改
clc,clear;
% annotationpath = 'C:\Users\mzt\Documents\MATLAB\tool\xml\';% H:\Resource\Cnds\output
annotationpath = 'C:\Users\mzt\Documents\MATLAB\tool\txt\';
xmloutpath = 'H:\Resource\Cnds\VOC\Annotations\';
videodir = 'I:\note\data2\frame\';
imgoutpath='H:\Resource\Cnds\VOC\JPEGImages\';
txtoutpath='H:\Resource\Cnds\VOC\ImageSets\Main\';
generateMode='train';%train w.r.t.1-45,except Can5-9;test w.r.t. Can5-9
gapval=2;% set gap value
annotationnms = dir([annotationpath '*.txt']);
annonumber = length(annotationnms);
% 循环读取annotations，生成xml文件
% for i=1:(length(annotationnms)-5)%if generateMode=test,i=41:annonumber
for i=1:annonumber
    % open file
    antid = fopen([annotationpath, annotationnms(i).name]);
    nodestruct=struct();
    txtstruct=struct();
    cnt=-1;
    videoname = annotationnms(i).name(1:end-4);
    videoframepath = [videodir videoname '\0\'];
    % readlines if outofside=0 and parse content, create xml filename
    while ~feof(antid)
        linestr = fgetl(antid);
        S = regexp(linestr, ' ', 'split');
        if strcmp(char(S{7}),'0')
            cnt=cnt+1;
            if rem(cnt,gapval) == 0
                x1 = char(S{2}); y1 = char(S{3});x2 = char(S{4}); y2 = char(S{5});
                frameid = str2num(S{6});fmidint=frameid; frameid = num2str(frameid, '%06d');
                occluded = char(S{8}); labelname = char(S{10});labelname=labelname(2:end-1);
                if strcmp(labelname,'60')||strcmp(labelname,'70')||strcmp(labelname,'80')
                    labelname=['c' labelname];
                end
                labelS=initLabelStruct();
                if isfield(labelS,labelname)
%                 if strcmp(labelname,'goround')||strcmp(labelname,'goforward')||strcmp(labelname,'goleft')...
%                         ||strcmp(labelname,'stopround')||strcmp(labelname,'stopforward')||strcmp(labelname,'stopleft')
                    newxmlname = [videoname frameid];
                    %% parse txt and copy image from frame source to voc JPEGimages
                    if ~exist([imgoutpath newxmlname '.jpg'],'file')
                        % parse img source location
                        dirnum = floor(fmidint/100);dirnum=num2str(dirnum);
                        copyfile([videoframepath dirnum '\' num2str(fmidint) '.jpg'], [imgoutpath '\' newxmlname '.jpg']);
                    end

                    %% create a object node and save in array
                    newNode=createObject2(labelname,x2,x1,y2,y1,occluded);
                    if ~isfield(nodestruct, newxmlname)
                        nodestruct.(newxmlname) = [newNode];
                    else
                        nodearray=nodestruct.(newxmlname);
                        nodearray=[nodearray newNode];
                        nodestruct.(newxmlname)=nodearray;
                    end

                    %% create each class txt
                    if ~isfield(txtstruct, labelname)
                        txtstruct.(labelname) = [newxmlname];
                    else
                        txtarray=txtstruct.(labelname);
                        txtarray=[txtarray;newxmlname];
                        txtstruct.(labelname)=txtarray;
                    end
                end
            end
        end
    end
    % append node and write xml
    fields=fieldnames(nodestruct);
    for k=1:length(fields)
        nodearrays = nodestruct.(fields{k});
        % write each frame objects
        writemyXml(nodearrays,fields{k},xmloutpath);
    end
    % write txt
    txtfields=fieldnames(txtstruct);
    for k1=1:length(txtfields)
        txtarrays=txtstruct.(txtfields{k1});
        writemyTxt(txtarrays,txtfields{k1},txtoutpath,generateMode,'1');
    end
    % close file
    fclose(antid);
    if rem(i,1) == 0
        disp([' ' num2str(i)]);
    end
end