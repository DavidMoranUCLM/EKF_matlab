function logs_ctx = update(logs_ctx, kalman_ctx, state)
i = logs_ctx.i;
logs_ctx.T(i) = kalman_ctx.t;
logs_ctx.q_current(:,i) = kalman_ctx.q_current;
logs_ctx.P_current(:,:,i) = kalman_ctx.P_current;
logs_ctx.a(:,i) = kalman_ctx.a;
logs_ctx.w(:,i) = kalman_ctx.w;
logs_ctx.m(:,i) = kalman_ctx.m;
logs_ctx.state(:,i) = state;
logs_ctx.i = i+1;

%Usar addpoint

if mod(logs_ctx.i,100)==0
eulerAng = so3(logs_ctx.q_current',"quat").eul;

logs_ctx.pHeading(1).YData = eulerAng(:,1);
logs_ctx.pHeading(1).XData = logs_ctx.T;

logs_ctx.pHeading(2).YData = logs_ctx.state(3,:);
logs_ctx.pHeading(2).XData = logs_ctx.T;


logs_ctx.pPitch(1).YData = eulerAng(:,2);
logs_ctx.pPitch(1).XData = logs_ctx.T;

logs_ctx.pPitch(2).YData = logs_ctx.state(2,:);
logs_ctx.pPitch(2).XData = logs_ctx.T;


logs_ctx.pRoll(1).YData = eulerAng(:,3);
logs_ctx.pRoll(1).XData = logs_ctx.T;

logs_ctx.pRoll(2).YData = logs_ctx.state(1,:);
logs_ctx.pRoll(2).XData = logs_ctx.T;

%drawnow limitrate
%refresh

end
end