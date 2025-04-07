function w = roll(t)
T1 = 2;
T2 = 4;

%w = ones(size(t));
w(:) = 0;
%w(:) = -0.1*t*10;
%w(((t < T1) | (t > T2))) = pi*cos(t((t < T1) | (t > T2)))/2;
%w(~((t < T1) | (t > T2))) = 0.5;
end