% grab simulation data
tout = out.tout;
q1 = out.q1.Data;
q2 = out.q2.Data;

% interpolate
x_1 = @(t) L1*cos(interp1(tout, q1, t, 'spline'));
y_1 = @(t) L1*sin(interp1(tout, q1, t, 'spline'));

x_2 = @(t) x_1(t) + L2*cos(interp1(tout, q1+q2, t, 'spline'));
y_2 = @(t) y_1(t) + L2*sin(interp1(tout, q1+q2, t, 'spline'));

% animate
ax1 = subplot(1,1,1);

args = {"FrameRate", 30, "AnimationRange", [0 25]};
fanimator(ax1, @(t) plot([0 x_1(t)],[0 y_1(t)],'k-','LineWidth',4), args{:}); 
hold on;
axis equal square;
xlim([-1.1*(L1+L2) 1.1*(L1+L2)]);
ylim([-1.1*(L1+L2) 1.1*(L1+L2)]);
grid on;

fanimator(ax1, @(t) plot([x_1(t) x_2(t)],[y_1(t) y_2(t)],'b-','LineWidth',4), args{:});
fanimator(ax1, @(t) text(-0.3,0.3+L1+L2,"Time: "+num2str(t,3)), args{:});
hold off;

% ax2 = subplot(1,2,2);
% fanimator(ax2, @(t) plot(0:1/30:t, interp1(tout, rad2deg(q1), 0:1/30:t, 'spline'),'k-'), args{:}); hold on;
% fanimator(ax2, @(t) plot(0:1/30:t, interp1(tout, rad2deg(q2), 0:1/30:t, 'spline'),'b-'), args{:});
% fanimator(ax2, @(t) plot(t, interp1(tout, rad2deg(q1), t, 'spline'), 'ko'), args{:});
% fanimator(ax2, @(t) plot(t, interp1(tout, rad2deg(q2), t, 'spline'), 'bo'), args{:});
% ylabel('$q_1,q_2$ (deg)','Interpreter','latex')
% hold off;

% 
% ax3 = subplot(3,3,6);
% fanimator(ax3, @(t) plot(0:1/30:t, interp1(sim_t, usat, 0:1/30:t, 'linear'), 'r'), args{:});
% hold on;
% fanimator(ax3, @(t) plot(t, interp1(sim_t, usat, t, 'linear'), 'ro'), args{:});
% ylabel('u_{sat}')
% hold off;
% 
% ax4 = subplot(3,3,9);
% fanimator(ax4, @(t) plot(0:1/30:t, interp1(sim_t, mode, 0:1/30:t, 'nearest'), 'g'), args{:});
% hold on;
% fanimator(ax4, @(t) plot(t, interp1(sim_t, mode, t, 'nearest'), 'go'), args{:});
% ylabel('mode')
% xlabel('Time (s)')
% hold off;

writeAnimation("./gif/test.gif",'LoopCount',Inf);