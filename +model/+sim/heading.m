function w = heading(t)
T1 = 5;
T2 = 10;

w = ones(size(t));
w(:) = 0;%pi*cos(3*t)/3;
%w(((t < T1) | (t > T2))) = 2*pi+cos(2*t((t < T1) | (t > T2)));
%w(~((t < T1) | (t > T2))) = 0.5;
end