function logs_ctx = update(logs_ctx, kalman_ctx, state)
i = logs_ctx.i;
logs_ctx.T(i) = kalman_ctx.t;
logs_ctx.q_current(:,i) = kalman_ctx.q_current;
logs_ctx.P_current(:,:,i) = kalman_ctx.P_current;
logs_ctx.a(:,i) = kalman_ctx.a;
logs_ctx.w(:,i) = kalman_ctx.w;
logs_ctx.m(:,i) = kalman_ctx.m;
logs_ctx.state.roll(i) = state.roll;
logs_ctx.state.pitch(i) = state.pitch;
logs_ctx.state.heading(i) = state.heading;
logs_ctx.i = i+1;

%Usar addpoint

if mod(logs_ctx.i,100)==0
eulerAng = so3(logs_ctx.q_current',"quat").eul;

currentRoll = eulerAng(:,3);
currentPitch = eulerAng(:,2);
currentHeading = eulerAng(:,1);

logs_ctx.pHeading(1).YData = currentHeading;
logs_ctx.pHeading(1).XData = logs_ctx.T;

logs_ctx.pHeading(2).YData = logs_ctx.state.heading;
logs_ctx.pHeading(2).XData = logs_ctx.T;


logs_ctx.pPitch(1).YData = currentPitch;
logs_ctx.pPitch(1).XData = logs_ctx.T;

logs_ctx.pPitch(2).YData = logs_ctx.state.pitch;
logs_ctx.pPitch(2).XData = logs_ctx.T;


logs_ctx.pRoll(1).YData = currentRoll;
logs_ctx.pRoll(1).XData = logs_ctx.T;

logs_ctx.pRoll(2).YData = logs_ctx.state.roll;
logs_ctx.pRoll(2).XData = logs_ctx.T;

%drawnow limitrate
%refresh

end
end