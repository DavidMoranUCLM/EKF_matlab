function [ctx, startTimeSec] = init(host, port)

ctx.xSpeed = 1;
ctx.startTimeSec = posixtime(datetime('now'));

u = udpport("LocalHost",host,"LocalPort", port);
configureTerminator(u, "CR/LF");
configureCallback(u, "terminator", @callback)

ctx.u = u;
ctx.update = @model.udp.update;
ctx.deinit = @model.udp.deinit;
ctx.getTime = @model.udp.getTime;

while size(ctx.u.UserData,1)<2
    pause(0.001)
end

data = ctx.u.UserData(1,:);
ctx.u.UserData = ctx.u.UserData(2:end,:);

startTimeSec = double(data(1));
ctx.startTimeSec = startTimeSec;
end

function callback(u,~)

data = double(u.readline.split(',')');
u.UserData(end+1,:) = [ms2sec(data(1)), data(2:end)];

end

function out = ms2sec(t)
    out = t/1000;
end