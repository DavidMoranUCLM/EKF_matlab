function plots(logs_ctx)

eulP = zeros(3,size(logs_ctx.q_current,2));
for i=1:size(logs_ctx.q_current,2)
q = logs_ctx.q_current(:,i);
P = logs_ctx.P_current(:,:,i);
jac = utils.quatEulJacobian(q(1),q(2),q(3),q(4));
eulP(:,i) = diag(jac*P*jac');

end

CI = sqrt(2)*erfcinv(2*(1-0.9)).*sqrt(eulP)';


eulerAng = so3(logs_ctx.q_current',"quat").eul("ZYX");
eulerAng(:,1) = eulerAng(:,1);
figure

subplot(3,1,1);
hold on
plot(logs_ctx.T,eulerAng(:,1)+CI(:,1), 'b-', "DisplayName","Estimado", "LineWidth",0.5);
plot(logs_ctx.T,eulerAng(:,1)-CI(:,1), 'b-', "DisplayName","Estimado", "LineWidth",0.5);
%plot(logs_ctx.T(1:end-1), logs_ctx.state(3,1:end-1), 'r-.',"DisplayName","Real");
grid on
ylim([-pi,pi])
xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Heading')
xlabel('t')
ylabel('rad')

subplot(3,1,2);
hold on
plot(logs_ctx.T,eulerAng(:,2)+CI(:,2), 'g-', "DisplayName","Estimado","LineWidth",0.5);
plot(logs_ctx.T,eulerAng(:,2)-CI(:,2), 'g-', "DisplayName","Estimado","LineWidth",0.5);
%plot(logs_ctx.T(1:end-1),logs_ctx.state(2,1:end-1), 'r-.',"DisplayName","Real");
grid on
ylim([-pi,pi])
xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
title('Pitch')
xlabel('t')
ylabel('rad')

subplot(3,1,3);
hold on;
plot(logs_ctx.T,eulerAng(:,3)+CI(:,3), 'r-', "DisplayName","Estimado","LineWidth",0.5);
plot(logs_ctx.T,eulerAng(:,3)-CI(:,3), 'r-', "DisplayName","Estimado","LineWidth",0.5);
%plot(logs_ctx.T(1:end-1), logs_ctx.state(1,1:end-1), 'r-.',"DisplayName","Real");
ylim([-pi,pi])
xlim([logs_ctx.T(1), logs_ctx.T(end-1)])
grid on
title('Roll')
xlabel('t')
ylabel('rad')
end