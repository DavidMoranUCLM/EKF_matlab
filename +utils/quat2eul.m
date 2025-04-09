function [eul] = quat2eul(q)
%q = q';
pitch = asin(2*(q(1,:).*q(3,:) - q(4,:).*q(2,:)));
roll  = atan2(2*(q(1,:).*q(2,:) + q(3,:).*q(4,:)), 1 - 2*(q(2,:).^2 + q(3,:).^2));
yaw = atan2(2*(q(1,:).*q(4,:)+q(1,:).*q(3,:)), 1-2*(q(3,:).*q(3,:)+q(4,:).*q(4,:)));

eul = [roll;pitch;yaw]';

end

