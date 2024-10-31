function w = pitch(t)
T1 = 0;
T2 = 10;

w = ones(size(t));
w(:) = 0;%pi*sin(6*t)/5;
%w(((t < T1) | (t > T2))) = 2*pi;
%w(~((t < T1) | (t > T2))) = 0.5;
end