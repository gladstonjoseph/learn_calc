clear all
clc
close all

global t_span; global accel_sensor_filt; global u; global m;

accel_data = load("accel_data.mat");
u = accel_data.u;
t_span = accel_data.t;
accel_sensor_noisy = accel_data.accel_sensor_noisy;

% Firt order low pass filter
filt = tf([4], [1, 4]);

accel_sensor_filt = accel_sensor_noisy; % lsim(filt, accel_sensor_noisy, t_span(1: end-1));

plot(t_span(1:end-1), accel_sensor_filt)
hold on
plot(t_span(1:end-1), accel_sensor_noisy)

m = 1.5;
b = 1;
k = 1;

param = [b, k];

param_optimize = fminsearch(@parameter_fitting, param);
% m = param_optimize(1);
b = 2.1; % param_optimize(1);
k = param_optimize(2);



[t_sim, y] = ode45(@(t, state) mass_spring_damper(t, state, u, t_span, m, b, k), t_span, [0; 0]);  % @ is specifying the changing variables
accel = diff(y(:, 2)) ./ diff(t_sim);  % (.) - Successive division

plot(t_sim(1:end-1), accel)

parameter_fitting(param_optimize)

function state_dot = mass_spring_damper(t, state, u, t_span, m, b, k)
    u_t = interp1(t_span, u, t);
    v = state(2); x = state(1);
    x_d = v;
    v_d = (1/m) * (u_t - (b*v) - (k*x));  %f(t) will not be a function of time, It's just input data.
    state_dot = [x_d; v_d];
end

function error = parameter_fitting(params)
    global t_span; global accel_sensor_filt; global u; global m;
    b = params(1); k = params(2);
    [t_sim, y] = ode45(@(t, state) mass_spring_damper(t, state, u, t_span, m, b, k), t_span, [0; 0]);  % @ is specifying the changing variables
    accel = diff(y(:, 2)) ./ diff(t_sim);  % (.) - Successive division
    error = sum((accel_sensor_filt - accel).^2);
end
