rho_aluminum = 2710; % kg/m^3
g = 9.81; % m/s^2

theta_0 = deg2rad(20);
x_0 = 0;

% Pendulum Arm (solid Aluminum)
L = 1; % 100 cm
Lc = L/2;
m = L*(0.05)*(0.05)*rho_aluminum; % 100cm x 5cm x 5cm
I = 1/3*m*L^2; % moment of inertia about the pivot

% Cart (Solid Aluminum)
cL = 0.3;
cH = 0.2;
M = cL*cH*0.1*rho_aluminum; % 20cm x 10cm x 10cm
