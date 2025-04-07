function w = heading(t)
T1 = 5;
T2 = 6;

%w = ones(size(t));
%w(:) = 0;
w(:) = -0.1*t*10;
%w(((t < T1) | (t > T2))) = cos(t((t < T1) | (t > T2)));
%w(~((t < T1) | (t > T2))) = 0.5;
end