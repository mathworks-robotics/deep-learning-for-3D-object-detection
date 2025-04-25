function lidarInfer()
%#codegen

node = ros2node("/detector_node");
pclSub = ros2subscriber(node, "/static_cloud","sensor_msgs/PointCloud2");

% Create a bounding box publisher
bboxPub = ros2publisher(node, '/bbox','std_msgs/Float32MultiArray');
bboxMsg = ros2message("std_msgs/Float32MultiArray");
% Create a label publisher
labelPub = ros2publisher(node, '/label', 'std_msgs/String');
labelMsg = ros2message("std_msgs/String");

r = ros2rate(node, 30);
reset(r);

while(1)
    [data, status, ~] = receive(pclSub, 10);
    if ~isempty(data)
        xyzData = rosReadXYZ(data, "PreserveStructureOnRead",true);
        intensityData = rosReadField(data, "intensity", "PreserveStructureOnRead",true);

        % pclData = pointCloud(rawData);

        [bboxes, scores, labels] = pillarPredict(xyzData, intensityData);
        [~,idx] = max(scores);

        bboxMsg.data = zeros(6, 1, 'single');
        labelMsg.data = '';

        if ~isempty(scores)
            bboxMsg.data = single(bboxes(idx,:)');
            label_data = cellstr(labels(idx));
            labelMsg.data = label_data{1};
        end

        send(bboxPub, bboxMsg);
        send(labelPub, labelMsg);
    end
    waitfor(r);
end
end