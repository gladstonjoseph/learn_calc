y_0 = 0
v_0 = 0
syms t s
F = laplace(sin(2*t))
IC = 3*s*y_0 + 3*v_0 + 2*y_0
Y = F/(3*s^2 + 2*s + 4) + IC/(3*s^2 + 2*s + 4)
y = ilaplace(Y)
y = vpa(y, 3)