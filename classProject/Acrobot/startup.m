rho_aluminum = 2710; % kg/m^3
g = 9.81; % m/s^2

L1 = 0.3; % 30 cm
Lc1 = L1/2;
m1 = L1*(0.03)*(0.03)*rho_aluminum; % 30cm x 3cm x 3cm
I1 = 1/3*m1*L1^2; % moment of inertia about the pivots

L2 = 1; % 100 cm
Lc2 = L2/2;
m2 = L2*(0.03)*(0.03)*rho_aluminum; % 30cm x 3cm 3cm
I2 = 1/3*m2*L2^2;

q1_0 = deg2rad(-10);
q2_0 = deg2rad(30);

% LQR
m11_0 = m1*Lc1^2 + m2*(L1^2 + Lc2^2 + 2*L1*Lc2*cos(0)) + I1 + I2;
m12_0 = m2*(Lc2^2 + L1*Lc2*cos(0)) + I2;
m22_0 = m2*Lc2^2 + I2;

M0 = [m11_0 m12_0; m12_0 m22_0];
M0_inv = M0^-1;
dphi_dq = g*[m1*Lc1+m2*L1+m2*Lc2 m2*Lc2; m2*Lc2 m2*Lc2];

Alin = [zeros(2) eye(2); M0_inv*dphi_dq zeros(2)];
Blin = [zeros(2,1); M0_inv*[0;1]];
Q = diag([10 10 10 10]);
R = 1;
F = lqr(Alin, Blin, Q, R);

% controller mode
control_mode = 1; % nonlinear=1, LQR=2