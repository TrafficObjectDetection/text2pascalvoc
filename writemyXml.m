function writemyXml(nodearrays,filename,bpath)
    if ~exist([bpath filename '.xml'],'file')
        docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
        docRootNode=docNode.getDocumentElement;
    %     docRootNode.setAttribute('attr_name','attr_value');
        folderNode=docNode.createElement('folder');
        folderNode.appendChild(docNode.createTextNode('VOC2007'));
        docRootNode.appendChild(folderNode);

        filenameNode=docNode.createElement('filename');
        filenameNode.appendChild(docNode.createTextNode([filename '.jpg']));
        docRootNode.appendChild(filenameNode);
        
        sourceNode=docNode.createElement('source');
        docRootNode.appendChild(sourceNode);
            databaseNode=docNode.createElement('database');
            databaseNode.appendChild(docNode.createTextNode('vatic'));
            sourceNode.appendChild(databaseNode);
            
            annoNode=docNode.createElement('annotation');
            annoNode.appendChild(docNode.createTextNode('Can'));
            sourceNode.appendChild(annoNode);

            imageNode=docNode.createElement('image');
            imageNode.appendChild(docNode.createTextNode('vatic'));
            sourceNode.appendChild(imageNode);
            
            flickNode=docNode.createElement('flickrid');
            flickNode.appendChild(docNode.createTextNode('vatic'));
            sourceNode.appendChild(flickNode);

        ownerNode=docNode.createElement('owner');
        docRootNode.appendChild(ownerNode);
            flickridNode=docNode.createElement('flickrid');
            flickridNode.appendChild(docNode.createTextNode('vatic'));
            ownerNode.appendChild(flickridNode);

            nameNode=docNode.createElement('name');
            nameNode.appendChild(docNode.createTextNode('vatic'));
            ownerNode.appendChild(nameNode);
            
        sizeNode=docNode.createElement('size');
        docRootNode.appendChild(sizeNode);
            widthNode=docNode.createElement('width');
            widthNode.appendChild(docNode.createTextNode('720'));
            sizeNode.appendChild(widthNode);

            heightNode=docNode.createElement('height');
            heightNode.appendChild(docNode.createTextNode('1280'));
            sizeNode.appendChild(heightNode);
            
            depNode=docNode.createElement('depth');
            depNode.appendChild(docNode.createTextNode('3'));
            sizeNode.appendChild(depNode);

        segmentNode=docNode.createElement('segmented');
        segmentNode.appendChild(docNode.createTextNode('0'));
        docRootNode.appendChild(segmentNode);
        % for each filed in mystruct,write a xml w.r.t. nodearray
        for j=1:length(nodearrays)
            childnds=nodearrays(j).getChildNodes();
            l1=childnds.getLength();
            labelname=childnds.item(0).getTextContent();
            % get bndbox childnodes.xmax xmin ymax ymin
            bndboxnds=childnds.item(1).getChildNodes();
            l2 = bndboxnds.getLength();
            x2=bndboxnds.item(0).getTextContent();
            x1=bndboxnds.item(1).getTextContent();
            y2=bndboxnds.item(2).getTextContent();
            y1=bndboxnds.item(3).getTextContent();
            % ---------------------
    %         diffcult=childnds.item(2).getTextContent();
            occluded=childnds.item(3).getTextContent();
    %         pose=childnds.item(4).getTextContent();
    %         truncated=childnds.item(5).getTextContent();
            if ~strcmp(labelname,'background')
            
        
            %-----------create object struture-------------
            objNode = docNode.createElement('object'); 

            nmNode = docNode.createElement('name'); 
            nmNode.appendChild(docNode.createTextNode(labelname));
            objNode.appendChild(nmNode);

            poseNode = docNode.createElement('pose');
            poseNode.appendChild(docNode.createTextNode('Unspecified'));
            objNode.appendChild(poseNode);

            truncatedNode = docNode.createElement('truncated');
            truncatedNode.appendChild(docNode.createTextNode('0'));
            objNode.appendChild(truncatedNode);
            
            diffcultNode = docNode.createElement('difficult');
            diffcultNode.appendChild(docNode.createTextNode('0'));
            objNode.appendChild(diffcultNode);
            
            bndboxnds = docNode.createElement('bndbox'); 
            objNode.appendChild(bndboxnds);
                xmin = docNode.createElement('xmin');
                xmin.appendChild(docNode.createTextNode(x1));
                bndboxnds.appendChild(xmin);

                ymin = docNode.createElement('ymin');
                ymin.appendChild(docNode.createTextNode(y1));
                bndboxnds.appendChild(ymin);

                xmax = docNode.createElement('xmax');
                xmax.appendChild(docNode.createTextNode(x2));
                bndboxnds.appendChild(xmax);
                
                ymax = docNode.createElement('ymax');
                ymax.appendChild(docNode.createTextNode(y2));
                bndboxnds.appendChild(ymax);
%                 xmax = docNode.createElement('xmax');
%                 xmax.appendChild(docNode.createTextNode(x2));
%                 bndboxnds.appendChild(xmax);
% 
%                 xmin = docNode.createElement('xmin');
%                 xmin.appendChild(docNode.createTextNode(x1));
%                 bndboxnds.appendChild(xmin);
% 
%                 ymax = docNode.createElement('ymax');
%                 ymax.appendChild(docNode.createTextNode(y2));
%                 bndboxnds.appendChild(ymax);
% 
%                 ymin = docNode.createElement('ymin');
%                 ymin.appendChild(docNode.createTextNode(y1));
%                 bndboxnds.appendChild(ymin);

%                 diffcultNode = docNode.createElement('diffcult');
%                 diffcultNode.appendChild(docNode.createTextNode('0'));
%                 objNode.appendChild(diffcultNode);
% %                 ocldNode = docNode.createElement('occluded');
% %                 ocldNode.appendChild(docNode.createTextNode(occluded));
% %                 objNode.appendChild(ocldNode);
%                 poseNode = docNode.createElement('pose');
%                 poseNode.appendChild(docNode.createTextNode('Unspecified'));
%                 objNode.appendChild(poseNode);
%                 truncatedNode = docNode.createElement('truncated');
%                 truncatedNode.appendChild(docNode.createTextNode('0'));
%                 objNode.appendChild(truncatedNode);
            %-----------create object struture-------------

            docRootNode.appendChild(objNode);
            end
        end
        % create common nodes
%         segmentNode=docNode.createElement('segmented');
%         segmentNode.appendChild(docNode.createTextNode('0'));
%         docRootNode.appendChild(segmentNode);

%         sizeNode=docNode.createElement('size');
%         docRootNode.appendChild(sizeNode);
%             depNode=docNode.createElement('depth');
%             depNode.appendChild(docNode.createTextNode('3'));
%             sizeNode.appendChild(depNode);
% 
%             heightNode=docNode.createElement('height');
%             heightNode.appendChild(docNode.createTextNode('1280'));
%             sizeNode.appendChild(heightNode);
% 
%             widthNode=docNode.createElement('width');
%             widthNode.appendChild(docNode.createTextNode('720'));
%             sizeNode.appendChild(widthNode);

%         sourceNode=docNode.createElement('source');
%         docRootNode.appendChild(sourceNode);
%             annoNode=docNode.createElement('annotation');
%             annoNode.appendChild(docNode.createTextNode('Can'));
%             sourceNode.appendChild(annoNode);
% 
%             databaseNode=docNode.createElement('database');
%             databaseNode.appendChild(docNode.createTextNode('vatic'));
%             sourceNode.appendChild(databaseNode);
% 
%             imageNode=docNode.createElement('image');
%             imageNode.appendChild(docNode.createTextNode('vatic'));
%             sourceNode.appendChild(imageNode);

%         ownerNode=docNode.createElement('owner');
%         docRootNode.appendChild(ownerNode);
%             flickridNode=docNode.createElement('flickrid');
%             flickridNode.appendChild(docNode.createTextNode('vatic'));
%             ownerNode.appendChild(flickridNode);
% 
%             nameNode=docNode.createElement('name');
%             nameNode.appendChild(docNode.createTextNode('vatic'));
%             ownerNode.appendChild(nameNode);
    % write each frame objects
    
        xmlwrite([bpath filename '.xml'],docNode);
    end
end