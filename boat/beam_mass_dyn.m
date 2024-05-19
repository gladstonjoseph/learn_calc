function x_dot = beam_mass_dyn(x, u)
    % Constants
    g = 9.81; % Gravity
    m = 300; % Mass
    J = 1000; % Moment of inertia
    k = 0.2; % Spring constant
    c = 0.4; % Damping coefficient
    
    % States
    d = x(1);
    d_dot = x(2);
    theta = x(3);
    theta_dot = x(4);
    
    % Motor force
    tau = u;
    
    
    x_dot = zeros(4, 1);
    x_dot(1) = d_dot;
    x_dot(2) = -g * sin(theta)
    x_dot(3) = theta_dot;
    x_dot(4) = (tau - k * theta - c * theta_dot - m * g * d * cos(theta)) / J;
end