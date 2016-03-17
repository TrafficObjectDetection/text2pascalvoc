% before run U need to set each file all needed path,
% especially gapval in creatVOCxml,to choose frame/gap
fprintf('---start parsing---\n');
createVOCxml;
fprintf('---create class text---\n')
combineTxt;
combineTxtlines;
fprintf('---creat train and test txt---\n')
createTrain_test;
fprintf('---done---');