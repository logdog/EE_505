rho_aluminum = 2710; % kg/m^3
g = 9.81; % m/s^2

L = 1.5; % 150 cm
Lc = L/2;
m = L*(0.03)*(0.03)*rho_aluminum; % 100cm x 3cm x 3cm
I = 1/3*m*L^2; % moment of inertia about the pivot

q_0 = deg2rad(-80);

% LQR
A = [0 1; m*g 0];
B = [0; 1];

Q = 10*eye(2);
R = 1;

F = lqr(A,B,Q,R);