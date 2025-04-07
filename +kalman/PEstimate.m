function PEst = PEstimate(P_prev, F, Q)
PEst = F*P_prev*F' + Q;
end