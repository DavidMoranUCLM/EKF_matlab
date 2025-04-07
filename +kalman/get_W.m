function W = get_W(q0, deltaT)
    W = (deltaT/2).*[-q0(2), -q0(3), -q0(4);
                     q0(1), -q0(4), q0(3);
                     q0(4), q0(1), -q0(2);
                     -q0(3), q0(2), q0(1)];
end