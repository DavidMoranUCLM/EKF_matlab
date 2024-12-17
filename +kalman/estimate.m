function ctx = estimate(ctx)

    ctx = qEst(ctx);
    ctx = PEst(ctx);

end


function ctx = qEst(ctx)
    w = ctx.w;
    q0 = ctx.q_prev;
    order = ctx.estimateOrder;
    deltaT = ctx.t-ctx.t_prev;

    %ctx.q_est = qEstPrimitive(w, q0, order, deltaT);
    ctx.q_est = (eye(4) + utils.extendedSkewMatrix(w).*deltaT./2)*q0;
end


function ctx = PEst(ctx)

    P0 = ctx.P_prev;

    F = getF(ctx);
    Q = getQ(ctx);

    ctx.P_est = F*P0*F' + Q;

end

function F = getF(ctx)
    w = ctx.w;
    q0 = ctx.q_prev;
    order = ctx.estimateOrder;
    deltaT = ctx.t-ctx.t_prev;
    h = ctx.h;

    %f = @(X) qEstPrimitive(w,X,order,deltaT);
    %F = utils.jacobian(f, q0, h);
    F = eye(4) + (deltaT/2)*utils.extendedSkewMatrix(w);
end

function Q = getQ(ctx)
    sigma_omega = ctx.stdDev.w;
    W = getW(ctx);
    Q = W*(eye(3).*sigma_omega)*W';
end


function W = getW(ctx)
    w = ctx.w;
    q0 = ctx.q_prev;
    order = ctx.estimateOrder;
    deltaT = ctx.t-ctx.t_prev;
    h = ctx.h;

    %f = @(X) qEstPrimitive(X,q0,order,deltaT);
    %W = utils.jacobian(f, w, h);
    W = (deltaT/2).*[-q0(2), -q0(3), -q0(4);
                     q0(1), -q0(4), q0(3);
                     q0(4), q0(1), -q0(2);
                     -q0(3), q0(2), q0(1)];

end



function q_est = qEstPrimitive(w,q0,order,deltaT)
   
    qOmega = quaternion(0, w(1), w(2), w(3));
    qOmegaMat = utils.quat2mat(qOmega);

    q1Mat = eye(4);
    for o=1:order 
        q1Mat = q1Mat + (qOmegaMat^o)*(deltaT^o)/(factorial(o)*2^o);
    end

    q_est = q1Mat*q0;

end