function ctx = update(ctx, measures, currentTimeSec)

ctx.t_prev = ctx.t;
ctx.t = currentTimeSec;

ctx.q_prev = ctx.q_current;
ctx.q_current = zeros(size(ctx.q_current));
ctx.q_est = zeros(4,1);

ctx.P_est = zeros(4,4);
ctx.P_prev = ctx.P_current;
ctx.P_current = zeros(4,4);


ctx.a = measures.a;
ctx.m = measures.m;
ctx.w = measures.w;

if (ctx.t - ctx.lastYawCorrectionTime_s > ctx.YawCorrectionPeriod_s)
    ctx.q_prev = kalman.applyYawCorrection(ctx.q_prev, ctx.m)*0.25+ctx.q_prev*0.75;
    %ctx.P_prev(2,2) = ctx.P_prev(2,2)*1.5;
    ctx.lastYawCorrectionTime_s = ctx.t;
end
end