function writemyTxt(txtarrays,txtname,bpath,train,label)
    % label = 1 is norm class txt,label = -1 dui ying background
    % train is a string, note the train or test txt
    fulltxtpath = [bpath txtname '_' train '.txt'];
%     if exist(fulltxtpath,'file')
%         % append content at end of context
%         fopen(fulltxtpath,'a')
%     else
%         % open new file and write
%     end
    fid=fopen(fulltxtpath,'a+');
    tolnum=size(txtarrays,1);
    for i=1:tolnum
        fprintf(fid,'%s\n',[txtarrays(i,:) ' ' label]);
    end
%     fprintf(fid,'%s',[txtarrays(tolnum,:) ' 1']);
    fclose(fid);
end