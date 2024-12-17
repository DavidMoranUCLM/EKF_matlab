function ctx = correct(ctx)

    z = [ctx.a;ctx.m/norm(ctx.m)];
    h = get_h(ctx);
    v = z - h;

    H = get_H(ctx);
    K = get_K(ctx, H);

    ctx.q_current = ctx.q_est + K*v;
    ctx.P_current = (eye(4) - K*H)*ctx.P_est;


end

function K = get_K(ctx, H)
    
    P = ctx.P_est;
    R = get_R(ctx);
    S = get_S(ctx, H, R);


    K = P*H'*inv(S);

end

function S = get_S(ctx, H, R)

    P = ctx.P_est;
    S = H*P*H' + R;

end

function h = get_h(ctx)

    h = get_hPrimitive(ctx.q_est, ctx.lat);

end

function H = get_H(ctx)
    
    h = ctx.h;
    q = ctx.q_est;

    %f = @(X) get_hPrimitive(X, ctx.lat);
    %H = utils.jacobian(f,q,h);
    g = [0; 0; 9.8];
    r = [cosd(ctx.lat); 0; -sind(ctx.lat)];
    ug = cross(g,q(2:4));
    ur = cross(r,q(2:4));

    H_l = [ug; ur];
    H_r_top = utils.skewMatrix(ug+q(1)*g) + dot(q(2:4),g)*eye(3) - g*q(2:4)';
    H_r_bottom = utils.skewMatrix(ur+q(1)*r) + dot(q(2:4),r)*eye(3) - r*q(2:4)';

    H = 2*[H_l [H_r_top; H_r_bottom]];

end


function h = get_hPrimitive(q, lat)

    R = so3(q',"quat").rotm;

    expected_g = R*[0; 0; 9.8];
    expected_r = R*[cosd(lat); 0; -sind(lat)];

    h = [expected_g;expected_r];

end


function R = get_R(ctx)
    stdDev_m = ctx.stdDev.m;
    stdDev_a = ctx.stdDev.a;
    
    d = [ones(1,3)*stdDev_a, ones(1,3)*stdDev_m];
    R = diag(d);

end