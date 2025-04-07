function [ctx , startTimeSec] = init(datasetFilename)

ctx.dataset = load(datasetFilename, 'imu_acc','imu_gyr','imu_mag','sampling_rate', 'opt_quat', 'T');

startTimeSec = 0;
ctx.startTimeSec = startTimeSec;
ctx.currentTimeSec = startTimeSec;
if ctx.dataset.sampling_rate == -1
    ctx.T = ctx.dataset.T;
    ctx.stepTimeSec = -1;
else
ctx.stepTimeSec = 1/ctx.dataset.sampling_rate;
end
ctx.i = floor(startTimeSec/ctx.stepTimeSec)+1;
ctx.lat = 50;
ctx.inc = 5;
ctx.xSpeed = 1;
ctx.update = @model.dataset.update;
ctx.deinit = @(x) x;
ctx.getTime = @model.dataset.getTime;
end
