function J = jacobian(f,X0,h)

for i=1:length(X0)
dX = zeros(length(X0),1);
dX(i) = h;
dY1 = f(X0+dX);
dY2 = f(X0-dX);

J(:,i) = (dY1-dY2)/(2*h);
end

end