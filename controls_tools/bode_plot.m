clear all

num = 1;
den = [1 8 36 80 0];

% GH = tf(num, den);

s = zpk(0, [], 1)

GH = 1.3*(s+2)/(s^3 + s^2 + 6*s + 1)

nyquist(GH)



