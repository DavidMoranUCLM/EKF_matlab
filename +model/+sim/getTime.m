function t = getTime(ctx)
t = (posixtime(datetime('now')) - ctx.startTimeSec)*ctx.xSpeed;
end