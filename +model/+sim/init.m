function [ctx , startTimeSec] = init()

startTimeSec = posixtime(datetime('now'));
ctx.startTimeSec = startTimeSec;
ctx.lat = 39.96;
ctx.update = @model.sim.update;
ctx.deinit = @(x) x;
end

