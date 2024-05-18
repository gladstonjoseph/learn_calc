function x_dot = boat_dyn(x, u)
    cd = 0.2;
    cd_rot = 0.4;
    mom_inertia = 1000;
    mass = 300;
    length = 3;

    velocity_x = x(1); velocity_y = x(2); heading = x(3); heading_rate = x(4);
    thrust = u(1); thrust_ang = u(2);

    x_dot = zeros(4, 1);
    x_dot(1) = -(cd/mass) * sqrt(velocity_x^2 + velocity_y^2) * velocity_x + (thrust * cos(thrust_ang+heading));
    x_dot(2) = -(cd/mass) * sqrt(velocity_x^2 + velocity_y^2) * velocity_y + (thrust * sin(thrust_ang+heading));
    x_dot(3) = heading_rate;
    x_dot(4) = -(cd_rot/mom_inertia) * heading_rate^3 - ((thrust*length / mom_inertia) * sin(thrust_ang));


end


