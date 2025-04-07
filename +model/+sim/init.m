function [ctx , startTimeSec] = init(xSpeed)

startTimeSec = 0;
ctx.startTimeSec = startTimeSec;
ctx.currentTimeSec = startTimeSec;
ctx.stepTimeSec = 1e-2;
ctx.lat = 0;
ctx.xSpeed = xSpeed;
ctx.update = @model.sim.update;
ctx.deinit = @(x) x;
ctx.getTime = @model.sim.getTime;
end

