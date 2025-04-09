function kalman_ctx = init(model_ctx)
kalman_ctx.q_prev = zeros(4,1);
kalman_ctx.q_current = zeros(4,1);
kalman_ctx.q_est = zeros(4,1);
kalman_ctx.P_est = zeros(4,4);
kalman_ctx.P_prev = zeros(4,4);
kalman_ctx.P_current = zeros(4,4);

kalman_ctx.S = zeros(3,3);
kalman_ctx.H = zeros(3,4);
kalman_ctx.K = zeros(4,3);
kalman_ctx.invS = zeros(3,3);

kalman_ctx.W = zeros(4,3);
kalman_ctx.F = zeros(4,4);
kalman_ctx.Q = zeros(4,4);


kalman_ctx.a = zeros(3,1);
kalman_ctx.m = zeros(3,1);
kalman_ctx.w = zeros(3,1);
kalman_ctx.stdDev.a = 0;
kalman_ctx.stdDev.m = 0;
kalman_ctx.stdDev.w = [0,0,0];
kalman_ctx.estimateOrder = 1;
kalman_ctx.h = 1e-8;
kalman_ctx.t = 0;
kalman_ctx.t_prev = 0;
kalman_ctx.lat = model_ctx.lat;
kalman_ctx.inc = model_ctx.inc;
kalman_ctx.lastYawCorrectionTime_s = 0;
kalman_ctx.YawCorrectionPeriod_s = 0.5;
kalman_ctx = kalman.initConditions(kalman_ctx, model_ctx);
end