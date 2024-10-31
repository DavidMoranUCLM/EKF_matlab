function kalman_ctx = step(kalman_ctx, measures, currentTimeSec)
kalman_ctx = kalman.update(kalman_ctx, measures, currentTimeSec);
kalman_ctx = kalman.estimate(kalman_ctx);
kalman_ctx = kalman.correct(kalman_ctx);
kalman_ctx = kalman.norm(kalman_ctx);
end