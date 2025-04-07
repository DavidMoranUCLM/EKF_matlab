function q_est = qEstimate(w,deltaT,q0)

    q_est = (eye(4) + utils.extendedSkewMatrix(w).*deltaT./2)*q0;

end

