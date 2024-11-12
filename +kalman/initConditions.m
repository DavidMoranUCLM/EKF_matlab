function ctx = initConditions(ctx, model_ctx)
    ctx = qEstimate(ctx, model_ctx);
    ctx = PEstimate(ctx);

    ctx = stdDevSet(ctx);

end



function ctx = qEstimate(ctx, model_ctx)
    accMagAngTol = cosd(10);

    [model_ctx, measures, state, ctx.t] = model_ctx.update(model_ctx);
    m = measures.m/norm(measures.m);
    a = measures.a/norm(measures.a);
    dotProduct = abs(dot(a, m));
    modulesProduct = norm(a)*norm(m);

    while(dotProduct/modulesProduct > accMagAngTol)
        disp('Reintentando Obtener q0')
        [measures, state, ctx.t] = model_ctx.update(model_ctx);
        m = measures.m;
        a = measures.a;
        dotProduct = abs(dot(a, m));
        modulesProduct = norm(a)*norm(m);
        disp(dotProduct/modulesProduct)
        
    end

    magAccCrossProduct = cross(a,m);
    R_aprox = [m/norm(m), magAccCrossProduct/norm(magAccCrossProduct)  ,a/norm(a)];
    q = recoverQuatFromRot(R_aprox);

    ctx.q_current = q;


end

function ctx = PEstimate(ctx)

    ctx.P_current = eye(size(ctx.P_current));

end

function ctx = stdDevSet(ctx)

    ctx.stdDev.a = 1.5.^2;
    ctx.stdDev.m = 1.8.^2;
    ctx.stdDev.w = 1.3.^2;

end


function q = recoverQuatFromRot(Q)

    K_diag = diag([Q(1,1)-Q(2,2)-Q(3,3),Q(2,2)-Q(1,1)-Q(3,3),Q(3,3)-Q(1,1)-Q(2,2),Q(1,1)+Q(2,2)+Q(3,3)]);
    K = [0, Q(2,1)+Q(1,2), Q(3,1)+Q(3,1), Q(3,2)-Q(3,2);
         0,0, Q(3,2)+Q(2,3), Q(1,3)-Q(3,1);
         0,0,0, Q(2,1)-Q(1,2);
         0,0,0,0];
    K = K + K' + K_diag;
    
    [V,D] = eig(K);
    d = diag(D);
    i = find(d==max(d));
    q = V(:,i(1));
    q = [q(4);q(1:3)];

end