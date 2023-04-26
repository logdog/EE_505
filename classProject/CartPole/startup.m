clear;
rho_aluminum = 2710; % kg/m^3
g = 9.81; % m/s^2

% initial conditions
theta_0 = deg2rad(179);
x_0 = 0;

% Pendulum Arm (point mass)
L = 1; % 100 cm
m = L*(0.05)*(0.05)*rho_aluminum; % 1kg

% Cart (Solid Aluminum)
cL = 0.3; % 30 cm
cH = 0.2; % 20 cm
M = cL*cH*0.1*rho_aluminum; % cL x cH x 10cm

% LQR stuff
m11 = 1/3*m*L^2;
m12 = 1/2*m*L*cos(0);
m22 = M+m;

M_inv = [m11 m12; m12 m22]^-1;
a = M_inv*[1/2*m*g*L 0; 0 0];
b = M_inv*[0;1];

A = [zeros(2) eye(2); a zeros(2)];
B = [0; 0; b];
Q = 10*diag([10 1 10 1]);
R = 1;

K = lqr(A,B,Q,R);

