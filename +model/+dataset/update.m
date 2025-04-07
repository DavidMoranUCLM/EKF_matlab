function [ctx,measures,state, t] = update(ctx)

i = ctx.i;
if ctx.stepTimeSec == -1
    t = ctx.T(i);
else
ctx.currentTimeSec = ctx.getTime(ctx)+ctx.stepTimeSec;
t = ctx.getTime(ctx);
end


lat = ctx.lat;

measures.a = ctx.dataset.imu_acc(i,:)';
measures.m = ctx.dataset.imu_mag(i,:)';
measures.w = ctx.dataset.imu_gyr(i,:)';

R = so3(ctx.dataset.opt_quat(i,:),"quat");

state.a = R.rotm'*[0;0;9.8];
state.m = R.rotm'*[0;cosd(ctx.lat);-sind(ctx.lat)];
state.w = [0;0;0];

eulerAngles = R.eul("ZYX");
state.roll = eulerAngles(3);
state.pitch = eulerAngles(2);
state.heading = eulerAngles(1);

ctx.i = ctx.i+1;


end

