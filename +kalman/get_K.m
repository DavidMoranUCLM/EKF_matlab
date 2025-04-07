function K = get_K(P, H, invS)
    K = P*H'*invS;
end