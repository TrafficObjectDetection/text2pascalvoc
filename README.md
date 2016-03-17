text2pascalvoc

*Introduction

This is a tool writed by matlab,pasring format txt file to create Pascal VOC dataset which contains Annotations,ImageSets,JPEGImages directory.
The txt should have this kind style:
id x1 y1 x2 y2 frame id outside occluded pred labename;
which is create and output by Vatic.


*Quick start
1. Run demo.m;
Note: before run demo.m you need to set the correct filepath for each file in demo.m,then modify initLabelStruct to suit your own labelname.You need also to set the gapval to choose frame per gapval.

2. Each matlab file in demo.m has description.It is easy to understand.