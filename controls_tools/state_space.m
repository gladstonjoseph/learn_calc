% MATLAB Example

A_lon = [-0.02, 0,     0,    0;
         -0.5, -0.8,   5.0,  0;
          0.01, -0.02, -1.0, 0;
          0,    0,     1,    0];

B_lon = [0;
         -0.6;
         -0.5;
          0];

C_lon = eye(4);
D_lon = zeros(4,1);

% Create state-space system
sys_lon = ss(A_lon, B_lon, C_lon, D_lon);

% Simulate response to elevator input
t = 0:0.01:10;
u = zeros(size(t));
u(t >= 1) = 1; % Step input at t = 1s
[y, t, x] = lsim(sys_lon, u, t);

% Plot results
plot(t, y);
xlabel('Time (s)');
ylabel('Response');
legend('Δu', 'Δw', 'Δq', 'Δθ');
