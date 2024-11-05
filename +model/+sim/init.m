function [ctx , startTimeSec] = init(xSpeed)

startTimeSec = posixtime(datetime('now'));
ctx.startTimeSec = startTimeSec;
ctx.lat = 39.96;
ctx.xSpeed = xSpeed;
ctx.update = @model.sim.update;
ctx.deinit = @(x) x;
end

