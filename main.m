clear;
%rng("default")


measureTimeSec = 120;

%[model_ctx, startTimeSec] = model.udp.init("10.0.0.3",1234);
%[model_ctx, startTimeSec] = model.sim.init(1);
[model_ctx, startTimeSec] = model.dataset.init('./logs/matlab14.mat');

kalman_ctx = kalman.init(model_ctx);
logs_ctx = log.init(kalman_ctx, startTimeSec, measureTimeSec, model_ctx.xSpeed);

prevTimeSec = 0;
while 1

    [model_ctx, measures, state, currentTimeSec] = model_ctx.update(model_ctx);

    kalman_ctx = kalman.step(kalman_ctx, measures, currentTimeSec);

    logs_ctx = log.update(logs_ctx, kalman_ctx, state);

    
    if currentTimeSec>measureTimeSec
        break
    end
    

    delayUntil(0, prevTimeSec, model_ctx.getTime(model_ctx));
    prevTimeSec = model_ctx.getTime(model_ctx);
end

model_ctx.deinit(model_ctx);
logs_ctx.deinit(logs_ctx);


%%

xShow = [ 200, 3000];

% figure;
% plot(reshape(logs_ctx.P_current, size(logs_ctx.P_current,1)*size(logs_ctx.P_current,2), [])');
% title("P")
% xlim(xShow);


figure;
plot(reshape(logs_ctx.H, size(logs_ctx.H,1)*size(logs_ctx.H,2), [])');
title("H")
xlim(xShow);

figure;
plot(reshape(logs_ctx.K, size(logs_ctx.K,1)*size(logs_ctx.K,2), [])');
title("K")
xlim(xShow);

figure;
plot(reshape(logs_ctx.S, size(logs_ctx.S,1)*size(logs_ctx.S,2), [])');
title("S")
xlim(xShow);

figure;
plot(reshape(logs_ctx.invS, size(logs_ctx.invS,1)*size(logs_ctx.invS,2), [])');
title("invS")
xlim(xShow);

figure;
plot(logs_ctx.measured.a')
hold on
title("acc")

R = so3(logs_ctx.q_current',"quat").rotm;
estimatedAcc = squeeze(pagemtimes(R, reshape(logs_ctx.measured.a, 3, 1, length(logs_ctx.measured.a))));
plot(estimatedAcc', '--')
legend
xlim(xShow);

figure;
plot(reshape(logs_ctx.q_est, size(logs_ctx.q_est,1), [])');
title("q_est")
xlim(xShow);

figure;
plot(reshape(logs_ctx.W, size(logs_ctx.W,1)*size(logs_ctx.W,2), [])');
title("W")
xlim(xShow);

figure;
plot(reshape(logs_ctx.Q, size(logs_ctx.Q,1)*size(logs_ctx.Q,2), [])');
title("Q")
xlim(xShow);

figure;
plot(reshape(logs_ctx.F, size(logs_ctx.F,1)*size(logs_ctx.F,2), [])');
title("F")
xlim(xShow);

%%
figure 
plot(logs_ctx.measured.m')
hold on
title("mag")
estimatedMag = squeeze(pagemtimes(R, reshape(logs_ctx.measured.m, 3, 1, length(logs_ctx.measured.m))));
plot(estimatedMag', '--')
%plot(logs_ctx.state.m', ".-")
legend

%%


function delayUntil(tStepSeconds, prevTimeSec, currentTimeSec)
Tstop = tStepSeconds-(currentTimeSec-prevTimeSec);
if Tstop > 0 && tStepSeconds ~= 0
    pause(Tstop);
else
    %warning("Lost %f seconds", Tstop);
    pause(0.000001);
end


end
