function w = roll(t)
T1 = 2;
T2 = 4;

w = ones(size(t));
w(:) = pi*cos(5*t)/2;
%w(((t < T1) | (t > T2))) = pi*cos(4*t((t < T1) | (t > T2)))/2;
%w(~((t < T1) | (t > T2))) = 0.5;
end