function [ctx,measures,state, t] = update(ctx)

ctx.currentTimeSec = ctx.getTime(ctx)+ctx.stepTimeSec*ctx.xSpeed;
t = ctx.getTime(ctx);


lat = ctx.lat;

roll = model.sim.roll(t);
pitch = model.sim.pitch(t);
heading = model.sim.heading(t);

delta_t = 1e-8;
w_roll = (roll-model.sim.roll(t-delta_t)) / (delta_t);
w_pitch = (pitch-model.sim.pitch(t-delta_t)) / (delta_t);
w_heading = (heading-model.sim.heading(t-delta_t)) / (delta_t);

R = so3([heading,pitch,roll],"eul",'ZYX');

measures.a = R.rotm*[0;0;9.8] + randn(3,1)*0.5;
measures.m = R.rotm*[cosd(lat);0;-sind(lat)] + randn(3,1)*0.8;
measures.w = [w_roll;w_pitch;w_heading] + randn(3,1)*0.3;

state.a = R.rotm*[0;0;9.8];
state.m = R.rotm*[cosd(lat);0;-sind(lat)];
state.w = [w_roll;w_pitch;w_heading];
state.roll = roll;
state.pitch = pitch;
state.heading = heading;

end