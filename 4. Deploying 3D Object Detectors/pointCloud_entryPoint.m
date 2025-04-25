% Load a test data point and convert it from point cloud to 3D array
pcloud = pcread("..\parkingLot\frame_0001.pcd");
pcloud_3d = pcloud.Location;
intensities = pcloud.Intensity;
[bboxes, scores, labels] = pillarPredict(pcloud_3d, intensities);