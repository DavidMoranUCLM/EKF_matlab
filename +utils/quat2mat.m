function M = quat2mat(q)

[w, x, y, z] = parts(q);

M = [w -x -y -z;
     x  w  z -y;
     y -z  w  x;
     z  y -x  w];

end