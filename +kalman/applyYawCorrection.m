% function q_out = applyYawCorrection(q,mag)
% 
% 
% pitch = asin(2*(q(1)*q(3)-q(2)*q(4)));
% roll = atan2(2*(q(1)*q(2)+q(3)*q(4)), 1-2*(q(2)*q(2)+q(3)*q(3)));
% 
% cr = cos(roll);
% sr = sin(roll);
% cp = cos(pitch);
% sp = sin(pitch);
% 
% eul(1) = roll;
% eul(2) = pitch;
% 
% correctedMag(1) = mag(1)*cr-mag(3)*sr;
% correctedMag(2) = mag(2)*cp + mag(1)*sp*sr + mag(3)*cp*cr;
% 
% eul(3) = atan2(correctedMag(2),correctedMag(1));
% 
% q_out = so3(eul,"eul","XYZ").quaternion.compact';
% 
% 
% end

function q_out = applyYawCorrection(q, mag)
    % Assumption: q = [w, x, y, z]
    % Convert original quaternion to Euler angles assuming ZYX convention:
    %   yaw (psi), pitch (theta), roll (phi)

    pitch = asin(2*(q(1)*q(3) - q(4)*q(2)));
    roll  = atan2(2*(q(1)*q(2) + q(3)*q(4)), 1 - 2*(q(2)^2 + q(3)^2));
    
    % Pre-calculate trigonometric functions for tilt compensation
    cp = cos(pitch);
    sp = sin(pitch);
    cr = cos(roll);
    sr = sin(roll);
    
    % Tilt-compensated magnetometer readings (using a common formula):
    %   Xh = Mx*cos(pitch) + Mz*sin(pitch)
    %   Yh = Mx*sin(roll)*sin(pitch) + My*cos(roll) - Mz*sin(roll)*cos(pitch)
    Xh = mag(1)*cp + mag(3)*sp;
    Yh = mag(1)*sr*sp + mag(2)*cr - mag(3)*sr*cp;
    
    % Compute corrected yaw from the tilt-compensated magnetometer
    new_yaw = -atan2(Yh, Xh)+pi/2;
    
    % Optionally: if you want the heading error (delta yaw), you can compute:
    % delta_yaw = new_yaw - yaw;
    % However, here we replace the yaw completely with new_yaw.
    
    % Reconstruct the quaternion using the new yaw and the original pitch & roll.
    % Using the ZYX (yaw-pitch-roll) conversion:
    %   Let:
    %     cy = cos(new_yaw/2), sy = sin(new_yaw/2)
    %     cp = cos(pitch/2),   sp = sin(pitch/2)
    %     cr = cos(roll/2),    sr = sin(roll/2)
    %   Then the quaternion is given by:
    %
    %   q_out = [cy*cp*cr + sy*sp*sr,  % w
    %            cy*cp*sr - sy*sp*cr,  % x
    %            cy*sp*cr + sy*cp*sr,  % y
    %            sy*cp*cr - cy*sp*sr]; % z
    
    cy = cos(new_yaw/2);
    sy = sin(new_yaw/2);
    cp_half = cos(pitch/2);
    sp_half = sin(pitch/2);
    cr_half = cos(roll/2);
    sr_half = sin(roll/2);
    
    q_out = [cy*cp_half*cr_half + sy*sp_half*sr_half, ...
             cy*cp_half*sr_half - sy*sp_half*cr_half, ...
             cy*sp_half*cr_half + sy*cp_half*sr_half, ...
             sy*cp_half*cr_half - cy*sp_half*sr_half]';
end
