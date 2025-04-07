function ctx = estimate(ctx)
    ctx = qEst(ctx);
    ctx = PEst(ctx);

end


function ctx = qEst(ctx)
    w = ctx.w;
    q0 = ctx.q_prev;
    deltaT = ctx.t-ctx.t_prev;
    ctx.q_est = kalman.qEstimate(w,deltaT,q0);
end


function ctx = PEst(ctx)

    ctx = getF(ctx);
    ctx = getQ(ctx);

    ctx.P_est = kalman.PEstimate(ctx.P_prev,ctx.F,ctx.Q);

end



function ctx = getF(ctx)
    w = ctx.w;
    deltaT = ctx.t-ctx.t_prev;
    ctx.F = kalman.get_F(w,deltaT);
end

function ctx = getQ(ctx)
    sigma_omega = ctx.stdDev.w;
    ctx = getW(ctx);
    ctx.Q = kalman.get_Q(ctx.W, sigma_omega);
end


function ctx = getW(ctx)
    q0 = ctx.q_prev;
    deltaT = ctx.t-ctx.t_prev;
    ctx.W = kalman.get_W(q0,deltaT);

end



% function q_est = qEstPrimitive(w,q0,order,deltaT)
% 
%     qOmega = quaternion(0, w(1), w(2), w(3));
%     qOmegaMat = utils.quat2mat(qOmega);
% 
%     q1Mat = eye(4);
%     for o=1:order 
%         q1Mat = q1Mat + (qOmegaMat^o)*(deltaT^o)/(factorial(o)*2^o);
%     end
% 
%     q_est = q1Mat*q0;
% 
% end