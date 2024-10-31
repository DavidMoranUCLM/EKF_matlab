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

end