N = 2:60; % looking at charges 2 to 60

% Found to be acceptable values to reach an equilibrium solution
tmax = 500;
level = 12;
gamma = 1;
epsec = 1.0e-3;

% Create/open the 2 files 
fid_v = fopen('vsurvey.dat', 'w');
fid_ec = fopen('ecsurvey.dat', 'w');

% Iterate through
for nc = N
    
    % Print current charge number we are performing the iteration over
    fprintf("nc = %d \n", nc);

    % Run the simulation
    r0 = 2*rand(nc,3) - 1;
    [t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec);

    % Write potential to vsurvey.dat
    fprintf(fid_v, '%3d %16.10f\n', nc, v(end));

    % Write equivalence classes to ecsurvey.dat
    fprintf(fid_ec, '%3d ', nc);
    fprintf(fid_ec, '%d ', v_ec);
    fprintf(fid_ec, '\n');

end

% Save and close files
fclose(fid_v);
fclose(fid_ec);