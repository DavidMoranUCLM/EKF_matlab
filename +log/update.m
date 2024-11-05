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

prevI = logs_ctx.update.prevI;
if logs_ctx.T(i)-logs_ctx.T(prevI) > logs_ctx.update.interval*logs_ctx.updateXSpeed

    eulerAng = so3(logs_ctx.q_current(:,prevI:i)',"quat").eul;
    
    currentRoll = eulerAng(:,3);
    currentPitch = eulerAng(:,2);
    currentHeading = eulerAng(:,1);
    
    addpoints(logs_ctx.pHeading(1), logs_ctx.T(prevI:i), currentHeading);
    addpoints(logs_ctx.pHeading(2), logs_ctx.T(prevI:i), logs_ctx.state.heading(prevI:i));
    
    addpoints(logs_ctx.pPitch(1), logs_ctx.T(prevI:i), currentPitch);
    addpoints(logs_ctx.pPitch(2), logs_ctx.T(prevI:i), logs_ctx.state.pitch(prevI:i));
    
    addpoints(logs_ctx.pRoll(1), logs_ctx.T(prevI:i), currentRoll);
    addpoints(logs_ctx.pRoll(2), logs_ctx.T(prevI:i), logs_ctx.state.roll(prevI:i));
    
    logs_ctx.update.prevI = i;

end

logs_ctx.i = i+1;
end