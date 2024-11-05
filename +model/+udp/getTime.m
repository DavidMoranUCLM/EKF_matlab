function t = getTime(ctx)
data = ctx.u.UserData(1,:);
t = (data(1)-ctx.startTimeSec);
end