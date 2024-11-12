function [ctx,measures,state,T] = update(ctx)
%UPDATE Summary of this function goes here
%   Detailed explanation goes here
while size(ctx.u.UserData,1)<2
    pause(0.0001)
end
data = ctx.u.UserData(1,:);
ctx.u.UserData = ctx.u.UserData(2:end,:);

T = ctx.getTime(ctx);

state.pitch = deg2rad(data(4));
state.roll = -deg2rad(data(3));
state.heading = (-deg2rad(data(2))+2*pi-pi/2);


measures.m = data(5:7)';
measures.m(2) = -measures.m(2);
measures.a = data(8:10)';
measures.a(2) = -measures.a(2);
measures.w = data(11:13)';
measures.w(2) = -measures.w(2);

state.a = measures.a;
state.w = measures.w;
state.m = measures.m;

% state = deg2rad(data([11:13])');
% 
% measures.a = data(2:4)';
% measures.m = data(5:7)';
% measures.w = data(8:10)';

end

