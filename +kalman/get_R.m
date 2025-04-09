function R = get_R(stdDev_a, stdDev_m)    
    d = [ones(1,3)*stdDev_a];
    R = diag(d);
end