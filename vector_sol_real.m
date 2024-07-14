function vec = vector_sol_real(u, intervalos)
h = 1 / intervalos;
n = intervalos - 1;
vec = zeros([n^2, 1]);

for j = 1 : n
    puntos = 1 : n;
    vec(n*(j-1) + 1 : n*j) = u(h * puntos, h * j);
end
end