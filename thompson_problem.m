
nc = 24;
tmax = 25;
level = 10;
gamma = 0.1;
epsec = 1.0e-5;

r0 = 2*rand(nc,3) - 1;
r0 = r0/norm(r0);
[t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

%charges_video(t, r);

[X,Y,Z] = sphere(100);
surf(X, Y, Z, 'FaceAlpha', 0.1, 'EdgeColor', 'none');
hold on;
for i = 1:nc
    plot3(r(i, 1, end), r(i, 2, end), r(i, 3, end), 'r*');
end
drawnow;
