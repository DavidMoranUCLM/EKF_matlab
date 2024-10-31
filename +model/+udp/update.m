function [measures,state,T] = update(ctx)
%UPDATE Summary of this function goes here
%   Detailed explanation goes here
while size(ctx.u.UserData,1)<1
    pause(0.0001)
end

data = ctx.u.UserData(1,:);
ctx.u.UserData = ctx.u.UserData(2:end,:);

T = (data(1)-ctx.startTimeSec);

state.pitch = -deg2rad(data(4));
state.roll = -deg2rad(data(3));
state.heading = (deg2rad(data(2))-pi);


measures.m = data(5:7)';
measures.a = data(8:10)';
measures.w = data(11:13)';


% state = deg2rad(data([11:13])');
% 
% measures.a = data(2:4)';
% measures.m = data(5:7)';
% measures.w = data(8:10)';

end

