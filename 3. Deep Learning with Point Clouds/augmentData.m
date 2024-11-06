function data = augmentData(data)
% Input: 1x3 cell containing pointCloud data, bounding boxes, and labels in
% that order. 
    
    % Define up to 45 deg rotation along the z axis, 
    % up to 30 pixel translation along x and y axes
    translationRange = [-30, 30];
    tform = randomAffine3d(Rotation = @selectRotation, ...
        XTranslation = translationRange, ...
        YTranslation = translationRange);
    
    % Apply transformation to the Point Cloud
    ptCloudTransformed = pctransform(data{1,1}, tform);
       
    % Define outputView based on the grid-size and limits of the point cloud
    gridSize = [100, 100, 100];
    xLimits = [min(ptCloudTransformed.Location(:,1)), max(ptCloudTransformed.Location(:,1))];
    yLimits = [min(ptCloudTransformed.Location(:,2)), max(ptCloudTransformed.Location(:,2))];
    zLimits = [min(ptCloudTransformed.Location(:,3)), max(ptCloudTransformed.Location(:,3))];
    
    outView = imref3d(gridSize,xLimits,yLimits,zLimits);
    
    % Apply the same transformation to the bboxes.
    bbox = data{1,2};
    [bbox,indices] = bboxwarp(bbox,tform,outView);

    % Assign new values back to data variable
    if ~isempty(indices)
        data{1,1} = ptCloudTransformed;
        data{1,2} = bbox;
        data{1,3} = data{1,3}(indices,:);
    end

end