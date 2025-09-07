nc = 4;
tmax = 10;
gamma = 1;
epsec = 1.0e-5;

% Initial charge distribution taken from project
r0 = [ [1, 0, 0]; [0, 1, 0]; [0, 0, 1]; (sqrt(3)/3) * [1, 1, 1] ];

% Run simulations for each discretization level
[t_10, r_10, v_10, v_ec_10] = charges(r0, tmax, 10, gamma, epsec);
[t_11, r_11, v_11, v_ec_11] = charges(r0, tmax, 11, gamma, epsec);
[t_12, r_12, v_12, v_ec_12] = charges(r0, tmax, 12, gamma, epsec);
[t_13, r_13, v_13, v_ec_13] = charges(r0, tmax, 13, gamma, epsec);

% Compute delta x values for the discretization levels
dx_10 = r_11(1, 1, 1:2:end) - r_10(1, 1, :);
dx_11 = r_12(1, 1, 1:2:end) - r_11(1, 1, :);
dx_12 = r_13(1, 1, 1:2:end) - r_12(1, 1, :);

% Scaling factor, either 2 or 4
rho = 4;

% Plot the graphs of all delta x values with respect to time
hold on;
title("Convergence test \rho = " + rho);
xlabel("Time");
ylabel("Scaled \delta");

plot(t_10, squeeze(dx_10));
plot(t_11, rho*squeeze(dx_11));
plot(t_12, rho*rho*squeeze(dx_12));
legend("\delta x_{10}", "\rho \delta x_{1}", "\rho^2 \delta x_{12}");
drawnow;
