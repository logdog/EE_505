% grab simulation data
tout = out.tout;
q = out.q.Data;

% interpolate
x_1 = @(t) L*cos(interp1(tout, q, t, 'spline'));
y_1 = @(t) L*sin(interp1(tout, q, t, 'spline'));

% animate
ax1 = subplot(1,1,1);

args = {"FrameRate", 30, "AnimationRange", [0 10]};
fanimator(ax1, @(t) plot([0 x_1(t)],[0 y_1(t)],'b-','LineWidth',4), args{:}); 
hold on;
axis equal square;
xlim([-1.1*(L) 1.1*(L)]);
ylim([-1.1*(L) 1.1*(L)]);
grid on;
fanimator(ax1, @(t) text(-0.3,0.3+L,"Time: "+num2str(t,3)), args{:});
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