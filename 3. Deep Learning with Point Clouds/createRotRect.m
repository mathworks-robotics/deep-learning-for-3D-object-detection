function data = createRotRect(data)
% This function is used to convert the labels to Rotated Rectangle format.

    numObs = size(data,1);
    for i = 1:numObs
        labels = data{i,1};
        classNames = data{i,2};
        if ~isempty(labels)
            % Convert to Rotated Rectangle format.
            data{i,1} = labels(:,[1,2,4,5,9]);
        else
            data{i,1} = [];
        end
    end
end