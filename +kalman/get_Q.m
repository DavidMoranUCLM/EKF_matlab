function Q = get_Q(W, sigma_omega)
    Q = W*(diag(sigma_omega))*W';
end