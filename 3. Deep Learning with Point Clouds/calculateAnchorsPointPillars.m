function anchors = calculateAnchorsPointPillars(labels)
%%%
% This function calculates the anchor boxes from the box labels in the
% training set. 
% labels = a table or timetable containing the labels for each class.
% anchors = a cell array of anchor boxes, two for each class. 
%%%

    anchors = [];
    classNames = labels.Properties.VariableNames;
    
    % Calculate the anchors for each class label.
    for ii = 1:numel(classNames)
        bboxCells = table2array(labels(:,ii));
        lwhValues = [];
        
        % Accumulate the lengths, widths, heights from the ground truth
        % labels.
        for i = 1 : height(bboxCells)
            bboxCell = bboxCells{i};
            if(~isempty(bboxCell))
                if(strcmp(class(bboxCell), "struct"))
                    bboxPositions = bboxCell.Position;
                    lwhValues = [lwhValues; bboxPositions(:, 4:6)];
                else
                    lwhValues = [lwhValues; bboxCell(:, 4:6)];
                end
            end
        end
        
        % Calculate the mean for each. 
        meanVal = mean(lwhValues, 1);
        
        % With the obtained mean values, create two anchors with two 
        % yaw angles, 0 and 90.
%         classAnchors = [{num2cell([meanVal, -1.78, 0])}, {num2cell([meanVal, -1.78, pi/2])}];
        classAnchors = [[meanVal, -1.78, 0]; [meanVal, -1.78, pi/2]];
        
        anchors = [anchors; {classAnchors}];
    end
end