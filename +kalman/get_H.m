function H = get_H(q,g,r)
%GETH Summary of this function goes here
%   Detailed explanation goes here


ug = cross(g,q(2:4));
%ur = cross(r,q(2:4));

H = 2*[ug utils.skewMatrix(ug+q(1)*g) + dot(g,q(2:4))*eye(3)-g*q(2:4)'];
end

