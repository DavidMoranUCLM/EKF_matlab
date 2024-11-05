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

    
    if currentTimeSec>measureTimeSec
        break
    end
    

    delayUntil(0.01, prevTimeSec, model_ctx.getTime(model_ctx));
    prevTimeSec = currentTimeSec;
end

model_ctx.deinit(model_ctx);
logs_ctx.deinit(logs_ctx);

function delayUntil(tStepSeconds, prevTimeSec, currentTimeSec)
Tstop = tStepSeconds-(currentTimeSec-prevTimeSec);
if Tstop > 0
    pause(Tstop);
else
    %warning("Lost %f seconds", Tstop);
    pause(0.000001);
end


end
