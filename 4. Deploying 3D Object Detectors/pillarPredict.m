function [bboxes, scores, labels] = pillarPredict(pcloud_3d, intensities)
%#codegen

    persistent mynet
    
    if isempty(mynet)
        mynet = coder.loadDeepLearningNetwork('detector.mat');
    end
    %Converting to pointCloud so the model can detect objects. pointCloud
    %function can be used in code generation
    pcloud = pointCloud(pcloud_3d, Intensity=intensities);
    
    [bboxes,scores,labels] = detect(mynet,pcloud,'Threshold',0.5);

end