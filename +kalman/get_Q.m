function Q = get_Q(W, sigma_omega)
    Q = W*(eye(3).*sigma_omega)*W';
end