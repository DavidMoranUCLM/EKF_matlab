function out = extendedSkewMatrix(v)
    out = [0 -v';[v -utils.skewMatrix(v)]];
end