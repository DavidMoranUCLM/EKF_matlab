clear;
%rng("default")

%startTimeSec = posixtime(datetime('now'));
%currentTimeSec = posixtime(datetime('now'));
measureTimeSec = 10;

[model_ctx, startTimeSec] = model.udp.init("10.0.0.3",1234);
%[model_ctx, startTimeSec] = model.sim.init();
currentTimeSec = startTimeSec;


kalman_ctx = kalman.init(model_ctx, currentTimeSec);
logs_ctx = log.init(kalman_ctx, startTimeSec);

prevTimeSec = 0;
while 1

    [measures, state, currentTimeSec] = model_ctx.update(model_ctx);

    kalman_ctx = kalman.step(kalman_ctx, measures, currentTimeSec);

    logs_ctx = log.update(logs_ctx, kalman_ctx, state);

    Tstop = 0.005-(currentTimeSec-prevTimeSec);
    if Tstop < 0
        Tstop = 0;
    end
    pause(Tstop)

    prevTimeSec = currentTimeSec;

    if currentTimeSec>measureTimeSec
        break
    end
end

drawnow
figure(2)
plot(diff(logs_ctx.T))
%log.plots(logs_ctx);

model_ctx.deinit(model_ctx);