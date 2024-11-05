function ctx = init(kalman_ctx, startTimeSec, stopTimeSec, xSpeed)

ctx.deinit = @log.deinit;

ctx.i = 1;

ctx.startTimeSec = startTimeSec;
ctx.T = zeros(1,1);
ctx.q_current = zeros(size(kalman_ctx.q_current,1),1);
ctx.P_current = zeros(size(kalman_ctx.P_current,1),size(kalman_ctx.P_current,2),1);
ctx.measured.a = zeros(size(kalman_ctx.a, 1), 1);
ctx.measured.w = zeros(size(kalman_ctx.w, 1), 1);
ctx.measured.m = zeros(size(kalman_ctx.m, 1), 1);

ctx.state.a = zeros(size(kalman_ctx.a, 1), 1);
ctx.state.w = zeros(size(kalman_ctx.w, 1), 1);
ctx.state.m = zeros(size(kalman_ctx.m, 1), 1);
ctx.state.heading = 0;
ctx.state.roll = 0;
ctx.state.pitch = 0;

ctx.update.interval = .25;
ctx.update.prevI = ctx.i;
ctx.updateXSpeed = xSpeed;

[pHeading, pPitch, pRoll] = createEulerStateplots(stopTimeSec);


ctx.pRoll = pRoll;
ctx.pHeading = pHeading;
ctx.pPitch = pPitch;

end

function [pHeading, pPitch, pRoll] = createEulerStateplots(stopTimeSec)

figure(1);
subplot(3,1,1);
hold on
pHeading(1) = animatedline(0,0,"Color",'blue', "LineStyle", "-", "DisplayName","Estimado", "LineWidth",1);
pHeading(2) = animatedline(0,0,"Color",'blue', "LineStyle", "-.", "DisplayName","Real");
grid on
xlim manual
ylim manual
xlim([0,stopTimeSec])
ylim([-pi,pi])

%xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Heading')
xlabel('t')
ylabel('rad')

subplot(3,1,2);
hold on
pPitch(1) = animatedline(0,0, "Color",'green', "LineStyle", "-", "DisplayName","Estimado","LineWidth",1);
pPitch(2) = animatedline(0,0,"Color",'green',"LineStyle", "-.","DisplayName","Real");
grid on
xlim manual
ylim manual
xlim([0,stopTimeSec])
ylim([-pi,pi])
%xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Pitch')
xlabel('t')
ylabel('rad')

subplot(3,1,3);
hold on;
pRoll(1) = animatedline(0,0,"Color",'red', "LineStyle", "-", "DisplayName","Estimado","LineWidth",1);
pRoll(2) = animatedline(0,0,"Color",'red',"LineStyle", "-.", "DisplayName","Real");
ylim manual
xlim manual
xlim([0,stopTimeSec])
ylim([-pi,pi])
%xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
grid on
title('Roll')
xlabel('t')
ylabel('rad')

%legend
end