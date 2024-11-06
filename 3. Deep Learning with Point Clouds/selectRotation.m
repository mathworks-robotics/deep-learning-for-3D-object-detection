function [rotationAxis,theta] = selectRotation
    rotationAxis = [0, 0, 1];
    theta = randi([-45, 45]);
end