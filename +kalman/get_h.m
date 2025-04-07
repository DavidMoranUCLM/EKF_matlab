function h = get_h(q,g,r)

R = so3(q',"quat").rotm';

expected_g = R*g;
expected_r = R*r;

h = [expected_g;expected_r];

end

