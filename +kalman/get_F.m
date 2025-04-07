function F = get_F(w, deltaT)
    F = eye(4) + (deltaT/2)*utils.extendedSkewMatrix(w);
end