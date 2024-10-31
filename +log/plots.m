function plots(logs_ctx)

eulerAng = so3(logs_ctx.q_current',"quat").eul;
eulerAng(:,1) = eulerAng(:,1);
figure

subplot(3,1,1);
hold on
plot(logs_ctx.T,eulerAng(:,1), 'b-', "DisplayName","Estimado", "LineWidth",1);
plot(logs_ctx.T(1:end-1), logs_ctx.state(3,1:end-1), 'r-.',"DisplayName","Real");
grid on
ylim([0,2*pi])
xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Heading')
xlabel('t')
ylabel('rad')

subplot(3,1,2);
hold on
plot(logs_ctx.T,eulerAng(:,2), 'g-', "DisplayName","Estimado","LineWidth",1);
plot(logs_ctx.T(1:end-1),logs_ctx.state(2,1:end-1), 'r-.',"DisplayName","Real");
grid on
ylim([-pi,pi])
xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Pitch')
xlabel('t')
ylabel('rad')

subplot(3,1,3);
hold on;
plot(logs_ctx.T,eulerAng(:,3), 'r-', "DisplayName","Estimado","LineWidth",1);
plot(logs_ctx.T(1:end-1), logs_ctx.state(1,1:end-1), 'r-.',"DisplayName","Real");
ylim([-pi,pi])
xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
grid on
title('Roll')
xlabel('t')
ylabel('rad')

legend
end