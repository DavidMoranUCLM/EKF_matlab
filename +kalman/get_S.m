function S = get_S(P_est, H, R)
    S = H*P_est*H' + R;
end