function [ctx, startTimeSec] = init(host, port)

ctx.startTimeSec = posixtime(datetime('now'));

u = udpport("LocalHost",host,"LocalPort", port);
configureTerminator(u, "CR/LF");
configureCallback(u, "terminator",@callback)

ctx.u = u;
ctx.update = @model.udp.update;
ctx.deinit = @model.udp.deinit;

while size(ctx.u.UserData,1)<1
    pause(0.0001)
end

data = ctx.u.UserData(1,:);
ctx.u.UserData = ctx.u.UserData(2:end,:);

startTimeSec = double(data(1));
ctx.startTimeSec = startTimeSec;
end

function callback(u,~)

data = u.readline.split(',')';
u.UserData(end+1,:) = [double(data(1))/1000, double(data(2:end))];

end