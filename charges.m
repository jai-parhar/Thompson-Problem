function [t, r, v, v_ec] = charges(r0, tmax, level, gamma, epsec)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% charges: Top-level function for solution of charges-on-a-sphere
% problem.
%
% Input arguments
%
% r0: Initial positions (nc x 3 array, where nc is the number of
% charges)
% tmax: Maximum simulation time
% level: Discretization level
% gamma: Dissipation coefficient
% epsec: Tolerance for equivalence class analysis
%
% Output arguments
%
% t: Vector of simulation times (length nt row vector)
% r: Positions of charges (nc x 3 x nt array)
% v: Potential vector (length nt row vector)
% v_ec: Equivalence class counts (row vector with length determined
% by equivalence class analysis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    nc = size(r0, 1); % Find number of charges from dimensions of r0
    
    % Initialize time variables
    nt = 2^(level) + 1;
    dt = tmax / 2^(level);
    t = linspace(0, tmax, nt);

    % Initialize potential values
    v = zeros(1, nt);

    r0 = r0/norm(r0); % Normalize r0 if it hasn't been already

    % Create r and initialize
    r = zeros(nc, 3, nt);
    r(:, :, 1) = r0;
    r(:, :, 2) = r0;    % Initial velocity is 0, so I will use r2 = r1

    % Find initial potential
    v(1) = calculate_voltage(r(:, :, 1));

    % Run simulation
    for n = 2:(nt-1)
        voltage = 0;
        for i = 1:nc

            coloumb_term = zeros(1, 3);

            % Calculate coloumb interaction term
            for j = 1:nc

                % Skip i==j, charge should not apply force to itself
                if i == j, continue; end;

                % Find r_ij
                r_ij = r(j, :, n) - r(i, :, n);

                % Compute coloumb force term from each charge
                coloumb_term = coloumb_term + r_ij/(norm(r_ij)^3);

                % Calculating voltage term for all n != 1 or n != nt
                if (i >= 2 && j <= (i-1))
                    voltage = voltage + 1/norm(r_ij);
                end

            end
            
            % Find next ith charge position
            r(i, :, n+1) = (2*r(i, :, n) + (gamma*dt/2 - 1).*r(i, :, n-1) - dt^2 .* coloumb_term)/(1 + gamma*dt/2);
            
            % Normalize the positions
            r(i, :, n+1) = r(i, :, n+1)/norm(r(i, :, n+1));

        end
        v(n) = voltage;
    end

    % Find voltage for the last timestep
    v(end) = calculate_voltage(r(:, :, end));

    % Run equivalence classes stuff
    [v_ec] = equivalence_classes(r(:, :, end), epsec);

end