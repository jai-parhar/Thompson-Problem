function [v_ec] = equivalence_classes(r_eq, epsec)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% equivalence_classes: Helper function to calculate equivalence classes
% given an equilibrium state
%
% Input arguments
%
% r_eq: Equilibrium positions (nc x 3 array, where nc is the number of
% charges)
% epsec: Tolerance for equivalence class analysis
%
% Output arguments
%
% v_ec: Equivalence class counts (row vector with length determined
% by equivalence class analysis)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nc = size(r_eq, 1);

d = zeros(nc, nc);

% Find all d_ij
for i = 1:nc
    for j = 1:nc
        d(i, j) = norm(r_eq(j, :) - r_eq(i, :));
    end
end

sorted_d = sort(d, 2); % Sorts along all rows

% Finds the number of unique rows that fit within the tolerance
unique_rows = uniquetol(sorted_d, epsec, "ByRows",true);

% Finds the number of equivalence classes by getting the number of unique
% rows
n_eq_classes = size(unique_rows, 1);

% Initialize vector of equivalence classes
v_ec = zeros(1, n_eq_classes);

% Iterate through all equivalence classes
for i = 1:n_eq_classes

    % Find the current class we wish to compare charge distance vectors 
    % against
    curr_row = unique_rows(i, :);

    % Iterate through all charge distance vectors
    for row_index = 1:size(sorted_d, 1)

        % If charge distance vector matches one of the unique charge
        % distance vectors to within tolereance, add a count to this charge
        % class
        if (norm(curr_row - sorted_d(row_index, :)) <= epsec)
            v_ec(i) = v_ec(i) + 1;
        end

    end

end

% Sort them into descending order because you told us to
v_ec = sort(v_ec, "descend");

end
