function logs_ctx = update(logs_ctx, kalman_ctx, state)
i = logs_ctx.i;
logs_ctx.T(i) = kalman_ctx.t;
logs_ctx.q_current(:,i) = kalman_ctx.q_current;
logs_ctx.P_current(:,:,i) = kalman_ctx.P_current;

logs_ctx.q_est(:,i) = kalman_ctx.q_est;

logs_ctx.S(:,:,i) = kalman_ctx.S;
logs_ctx.H(:,:,i) = kalman_ctx.H;
logs_ctx.K(:,:,i) = kalman_ctx.K;
logs_ctx.invS(:,:,i) = kalman_ctx.invS;

logs_ctx.W(:,:,i) = kalman_ctx.W;
logs_ctx.F(:,:,i) = kalman_ctx.F;
logs_ctx.Q(:,:,i) = kalman_ctx.Q;

logs_ctx.measured.a(:,i) = kalman_ctx.a;
logs_ctx.measured.w(:,i) = kalman_ctx.w;
logs_ctx.measured.m(:,i) = kalman_ctx.m;

logs_ctx.state.a(:,i) = state.a;
logs_ctx.state.w(:,i) = state.w;
logs_ctx.state.m(:,i) = state.m;
logs_ctx.state.roll(i) = state.roll;
logs_ctx.state.pitch(i) = state.pitch;
logs_ctx.state.heading(i) = state.heading;

prevI = logs_ctx.update.prevI;
if logs_ctx.T(i)-logs_ctx.T(prevI) > logs_ctx.update.interval*logs_ctx.updateXSpeed
    for j = prevI:i
        q = logs_ctx.q_current(:,j);
        P = logs_ctx.P_current(:,:,j);
        jac = utils.quatEulJacobian(q(1),q(2),q(3),q(4));
        eulP(:,j) = diag(jac*P*jac');
    end


    CI = (sqrt(2)*erfcinv(2*(1-0.95)).*sqrt(eulP))';

    eulerAng = so3(logs_ctx.q_current(:,prevI:i)',"quat").eul("ZYX");
    
    currentRoll = eulerAng(:,3);
    currentPitch = eulerAng(:,2);
    currentHeading = eulerAng(:,1);
    
    addpoints(logs_ctx.pHeading(1), logs_ctx.T(prevI:i), currentHeading+CI(prevI:i,1));
    addpoints(logs_ctx.pHeading(3), logs_ctx.T(prevI:i), currentHeading-CI(prevI:i,1));
    addpoints(logs_ctx.pHeading(2), logs_ctx.T(prevI:i), logs_ctx.state.heading(prevI:i));
    
    addpoints(logs_ctx.pPitch(1), logs_ctx.T(prevI:i), currentPitch+CI(prevI:i,2));
    addpoints(logs_ctx.pPitch(3), logs_ctx.T(prevI:i), currentPitch-CI(prevI:i,2));
    addpoints(logs_ctx.pPitch(2), logs_ctx.T(prevI:i), logs_ctx.state.pitch(prevI:i));
    
    addpoints(logs_ctx.pRoll(1), logs_ctx.T(prevI:i), currentRoll+CI(prevI:i,3));
    addpoints(logs_ctx.pRoll(3), logs_ctx.T(prevI:i), currentRoll-CI(prevI:i,3));
    addpoints(logs_ctx.pRoll(2), logs_ctx.T(prevI:i), logs_ctx.state.roll(prevI:i));
    
    logs_ctx.update.prevI = i;

end

logs_ctx.i = i+1;
end