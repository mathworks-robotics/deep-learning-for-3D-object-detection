function [bboxes, scores, labels] = pillarPredict(pcloud_3d)
%#codegen

persistent mynet

if isempty(mynet)
    mynet = coder.loadDeepLearningNetwork('detector.mat');
end

pcloud = pointCloud(pcloud_3d);

[bboxes,scores,labels] = detect(mynet,pcloud,'Threshold',0.5);

end
