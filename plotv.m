nc = 12;
tmax = 10;
level = 12;
gamma = 1;
epsec = 1.0e-5;

% Run simulation
r0 = 2*rand(nc,3) - 1;
[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

% Plot potential results
hold on;
title("Potential vs Time Graph");
xlabel("Time");
ylabel("Potential");
plot(t, v);
drawnow;