clear;
%rng("default")


measureTimeSec = 50;

%[model_ctx, startTimeSec] = model.udp.init("10.0.0.3",1234);
[model_ctx, startTimeSec] = model.sim.init(5);

currentTimeSec = startTimeSec;

kalman_ctx = kalman.init(model_ctx, currentTimeSec);
logs_ctx = log.init(kalman_ctx, startTimeSec, measureTimeSec, model_ctx.xSpeed);

prevTimeSec = 0;
while 1

    [measures, state, currentTimeSec] = model_ctx.update(model_ctx);

    kalman_ctx = kalman.step(kalman_ctx, measures, currentTimeSec);

    logs_ctx = log.update(logs_ctx, kalman_ctx, state);

    delayUntil(prevTimeSec,currentTimeSec);

    prevTimeSec = currentTimeSec;
    if currentTimeSec>measureTimeSec
        break
    end
end

model_ctx.deinit(model_ctx);
logs_ctx.deinit(logs_ctx);

function delayUntil(prevTimeSec, currentTimeSec)
Tstop = 0.05-(currentTimeSec-prevTimeSec);
if Tstop > 0
    pause(Tstop);
else
    %warning("Lost %f seconds", -Tstop);
end


end
