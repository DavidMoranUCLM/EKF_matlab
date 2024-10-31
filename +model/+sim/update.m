function [measures,state, t] = update(ctx)

T = posixtime(datetime('now'));
t = T-ctx.startTimeSec;

lat = ctx.lat;

roll = model.sim.roll(t);
pitch = model.sim.pitch(t);
heading = model.sim.heading(t);

delta_t = 1e-8;
w_roll = (roll-model.sim.roll(t-delta_t)) / (delta_t);
w_pitch = (pitch-model.sim.pitch(t-delta_t)) / (delta_t);
w_heading = (heading-model.sim.heading(t-delta_t)) / (delta_t);

R = so3([heading,pitch,roll],"eul",'ZYX');

measures.a = R.rotm*[0;0;9.8] + randn(3,1)/10;
measures.m = R.rotm*[cosd(lat);0;-sind(lat)] + randn(3,1)/5;
measures.w = [w_roll;w_pitch;w_heading] + randn(3,1)/15;

state = [roll;pitch;heading];

end