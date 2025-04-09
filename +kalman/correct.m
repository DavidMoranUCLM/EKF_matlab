function ctx = correct(ctx)

z = ctx.a;
h = get_h(ctx);
v = z - h;

ctx.R = get_R(ctx);
ctx = get_H(ctx);
ctx.S = get_S(ctx);

ctx = get_K(ctx);


ctx.q_current = kalman.qCorrect(ctx.q_est, ctx.K, v);
ctx.P_current = kalman.correctP(ctx.K,ctx.H,ctx.P_est, ctx.R);


end

function ctx = get_K(ctx)

ctx.invS = inv(ctx.S);
ctx.K = kalman.get_K(ctx.P_est, ctx.H, ctx.invS);

end

function S = get_S(ctx)

S = kalman.get_S(ctx.P_est, ctx.H, ctx.R);

end

function h = get_h(ctx)

g = [0; 0; 1];
%r = [sind(ctx.inc);cosd(ctx.lat)*cosd(ctx.inc);-sind(ctx.lat)*cosd(ctx.inc)];

h = kalman.get_h(ctx.q_est, g);

end

function ctx = get_H(ctx)

g = [0; 0; 1];
%r = [sind(ctx.inc);cosd(ctx.lat)*cosd(ctx.inc);-sind(ctx.lat)*cosd(ctx.inc)];

ctx.H = kalman.get_H(ctx.q_est, g);

end


function R = get_R(ctx)
R = kalman.get_R(ctx.stdDev.a);
end


