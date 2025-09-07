# Solver for the Thompson Problem

Computational solution to the Thompson problem of finding the minimum electrostatic potential configuration for N unit charges around a sphere, and a further analysis into these solutions. Written in MATLAB. Primarily written over the course of UBC course PHYS 410.

Simulates the normal Coulomb interaction between each charge, and includes a velocity damping term to allow the system to settle into a minimal electrostatic potential configuration

## File contents
This will explain the contents of each file at a high level. Further documentation exists within each source file, at the beginning of each function.

#### thompson_problem.m
The entrance point for the program. Runs the solver and generates a 3D plot of the final configuration of the charges around the sphere.

#### charges.m
Top level function for the dynamical simulation of the Thompson problem for N charges. Returns the charge positions and voltage for the configuration at each timestep, as well as the equivalence classes generated. These equivalence classes allow for analysis of the symmetries between each charge in the final configuration.

#### charges_plot.m
Creates a 3D plot for the configuration of any set of charges.

#### charges_video.m
Generates a video of the dynamics of the charges as they settle into the correct configuration.

#### convtest.m
Tests the convergence of the solver for various levels of temporal discretization, and generates a plot to demonstrate this convergence.

#### equivalence_classes.m
Generates the equivalence classes for each charge based on an inputted final charge configuration. Allows for the analysis of symmetries between charges.

#### plotv.m
Generates a plot of the electrostatic potential over time as a preset number of charges settles into the lowest potential configuration.

#### survey.m
Generates a list of the final potential energy and equivalence classes for varying numbers of charges, and saves them to 2 seperate `.dat` files.

#### calculate_voltage.m
Calculates the potential for a given charge configuration. Primarily used as a helper function in `charges.m`.
