% grab simulation data
tout = out.tout;
q1 = out.q1.Data; % q1 = theta
q2 = out.q2.Data; % q2 = x

% interpolate
x_cart = @(t) interp1(tout, q2, t, 'spline');
x_pend = @(t) x_cart(t) + L*sin(interp1(tout, q1, t, 'spline'));
y_pend = @(t) L*cos(interp1(tout, q1, t, 'spline'));

% animate
ax1 = subplot(1,1,1);

args = {"FrameRate", 30, "AnimationRange", [0 20]};
fanimator(ax1, ...
    @(t) rectangle('Position',[x_cart(t)-cL/2,-cH/2,cL,cH], ...
    'FaceColor','b'), args{:}); 
hold on;
axis equal;
xlim([-2 1.5]);
ylim([-1.5 1.5]);
grid on;
fanimator(ax1, @(t) plot([x_cart(t) x_pend(t)],[0 y_pend(t)],...
    'k-','LineWidth',4), args{:});
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