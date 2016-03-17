function newNode = createObject2(labelname,x2,x1,y2,y1,occluded)
%% create VOC xml object Node
    docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
%     docRootNode=docNode.getDocumentElement;
    %docRootNode.setAttribute('attr_name','attr_value');
%     folderNode=docNode.createElement('folder');
%     folderNode.appendChild(docNode.createTextNode('VOC2007'));
%     docRootNode.appendChild(folderNode);
    
%     filenameNode=docNode.createElement('filename');
%     filenameNode.appendChild(docNode.createTextNode([filename '.jpg']));
%     docRootNode.appendChild(filenameNode);
    
    objNode = docNode.createElement('object'); 

    nmNode = docNode.createElement('name'); 
    nmNode.appendChild(docNode.createTextNode(labelname));
    objNode.appendChild(nmNode);

    bndboxnds = docNode.createElement('bndbox'); 
    objNode.appendChild(bndboxnds);

        xmax = docNode.createElement('xmax');
        xmax.appendChild(docNode.createTextNode(x2));
        bndboxnds.appendChild(xmax);

        xmin = docNode.createElement('xmin');
        xmin.appendChild(docNode.createTextNode(x1));
        bndboxnds.appendChild(xmin);

        ymax = docNode.createElement('ymax');
        ymax.appendChild(docNode.createTextNode(y2));
        bndboxnds.appendChild(ymax);

        ymin = docNode.createElement('ymin');
        ymin.appendChild(docNode.createTextNode(y1));
        bndboxnds.appendChild(ymin);

        diffcultNode = docNode.createElement('difficult');
        diffcultNode.appendChild(docNode.createTextNode('0'));
        objNode.appendChild(diffcultNode);
        ocldNode = docNode.createElement('occluded');
        ocldNode.appendChild(docNode.createTextNode(occluded));
        objNode.appendChild(ocldNode);
        poseNode = docNode.createElement('pose');
        poseNode.appendChild(docNode.createTextNode('Unspecified'));
        objNode.appendChild(poseNode);
        truncatedNode = docNode.createElement('truncated');
        truncatedNode.appendChild(docNode.createTextNode('0'));
        objNode.appendChild(truncatedNode);
        newNode=objNode;
end
