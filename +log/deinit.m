function deinit(logs_ctx)

drawnow
figure(2);
subplot(1,2,1)
b = boxchart(diff(logs_ctx.T));
b.JitterOutliers = 'on';
b.MarkerStyle = 'o';
title("Time step size distribution")
ylabel("\Deltat (s)")
yscale log

subplot(1,2,2)
plot(diff(logs_ctx.T))
title("Time step size")
ylabel("\Deltat (s)")
xlabel("Steps")
yscale log

end

