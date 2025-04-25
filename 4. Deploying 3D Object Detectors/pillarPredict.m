function [bboxes, scores, labels] = pillarPredict(pcloud, intensities)
%#codegen

persistent mynet

if isempty(mynet)
    mynet = coder.loadDeepLearningNetwork('detector.mat');
end

pointCloud_xyz = single(zeros([32 1083 3]));
pointCloud_intensity = single(zeros([32 1083]));

pointCloud_xyz(:, :, 1) = pcloud(:, :, 1);
pointCloud_xyz(:, :, 2) = pcloud(:, :, 2);
pointCloud_xyz(:, :, 3) = pcloud(:, :, 3);

pointCloud_intensity(1:32, 1:1083) = intensities(1:32, 1:1083);

pcloud_3d = pointCloud(pointCloud_xyz);
pcloud_3d.Intensity = pointCloud_intensity;

[bboxes,scores,labels] = detect(mynet,pcloud_3d,'Threshold',0.5);

end
