clear all

% mass_spring_damper([0, 10], 50, 100, 2, 5)

m = 1.5;
b = 2.1;
k = 3.6;
t_span = [0 : 0.1 : 100];
u = sin(t_span);  % Input is pre-recorded.
[t, y] = ode45(@(t, state) mass_spring_damper(t, state, u, t_span, m, b, k), t_span, [0; 0]);  % @ is specifying the changing variables
% ode45 uses a variable time step

accel_sensor = diff(y(:, 2)) ./ diff(t_span');  % (.) - Successive division
accel_sensor_noisy = accel_sensor + (0.02 * randn(length(accel_sensor), 1));

plot(t_span(1: end-1), accel_sensor_noisy)
xlim([0, 100])



function state_dot = mass_spring_damper(t, state, u, t_span, m, b, k)
    u_t = interp1(t_span, u, t);
    v = state(2); x = state(1);
    x_d = v;
    v_d = (1/m) * (u_t - (b*v) - (k*x));  %f(t) will not be a function of time, It's just input data.
    state_dot = [x_d; v_d];
end
