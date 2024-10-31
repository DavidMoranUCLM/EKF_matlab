function ctx = init(kalman_ctx, startTimeSec)
ctx.i = 1;

ctx.startTimeSec = startTimeSec;
ctx.T = zeros(1,1);
ctx.q_current = zeros(size(kalman_ctx.q_current,1),1);
ctx.P_current = zeros(size(kalman_ctx.P_current,1),size(kalman_ctx.P_current,2),1);
ctx.a = zeros(size(kalman_ctx.a, 1), 1);
ctx.w = zeros(size(kalman_ctx.w, 1), 1);
ctx.m = zeros(size(kalman_ctx.m, 1), 1);
ctx.state.heading = 0;
ctx.state.roll = 0;
ctx.state.pitch = 0;

f = figure(1);
% subplot(3,1,1);
% pHeading = plot(0,0, "r-", 0, 0, "r-.");
% subplot(3,1,2);
% pPitch = plot(0,0, "b-", 0, 0, "b-.");
% subplot(3,1,3);
% pRoll = plot(0,0, "g-", 0, 0, "g-.");

subplot(3,1,1);
hold on
pHeading(1) = plot(0,0, 'b-', "DisplayName","Estimado", "LineWidth",1);
pHeading(2) = plot(0,0, 'r-.',"DisplayName","Real");
grid on
ylim([-pi,pi])
%xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Heading')
xlabel('t')
ylabel('rad')

subplot(3,1,2);
hold on
pPitch(1) = plot(0,0, 'g-', "DisplayName","Estimado","LineWidth",1);
pPitch(2) = plot(0,0, 'r-.',"DisplayName","Real");
grid on
ylim([-pi,pi])
%xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Pitch')
xlabel('t')
ylabel('rad')

subplot(3,1,3);
hold on;
pRoll(1) = plot(0,0, 'r-', "DisplayName","Estimado","LineWidth",1);
pRoll(2) = plot(0,0, 'r-.',"DisplayName","Real");
ylim([-pi,pi])
%xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
grid on
title('Roll')
xlabel('t')
ylabel('rad')

legend

ctx.fig = f;
ctx.pRoll = pRoll;
ctx.pHeading = pHeading;
ctx.pPitch = pPitch;

end