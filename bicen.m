% Calculates power and torque requirements while riding a conventional 
% human-powered bike or an electric bike driven by battery and motor.

% Author: Lalit Patnaik, DESE, IISc, Bangalore
% Date: 22 April 2013

% 26-04-2013: Checked that the same model (used for bicycle) holds for electric 
%             bikes too when the right parameter values are plugged in 
% 29-04-2013: Incorporated effect of slopes

% Assumptions:
% [1] The transmission (pedal-sprocket-chain assembly) is 100% efficient 
%     Note that practical efficiencies are in the range of 96-98%
% [2] The rider + bike system is moving at a constant velocity
% [3] There is no headwind, tailwind or crosswind

% References:
% [1] http://large.stanford.edu/courses/2010/ph240/stetler1/
% [2] http://www.technologystudent.com/gears1/gearat1.htm
% [3] http://www.slowtwitch.com/Tech/The_Physics_of_Moving_a_Bike_163.html
% [4] http://www.cyclingpowerlab.com/CyclingAerodynamics.aspx

% Note:
% [1] Crr could vary between 0.0021 to 0.017 as per reference [1]
% [2] Cdr could vary between 0.65 to 1.1 as per reference [1]
% [3] GR could be anywhere between 1.75 to 4 as per reference [2]
% [4] GR and Rw effect only the torque requirement but not the power requirement
% [5] For electric bikes with hub motors, GR=1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Crr = 0.01  % Coefficient of rolling friction (dimensionless) [1]
            % Varies with tyre pressure, tyre size (radius, width) and road surface
Mr  = 65    % Mass of rider (kg)
Mb  = 15    % Mass of bike (kg); ~80kg for electric bike
GR  = 2     % Gear Ratio = No. of teeth in driving sprocket / No. of teeth in driven sprocket
v   = 15;   % velocity (kmph)
v   = v/3.6 % velocity (m/s)
Rw  = 0.35  % Wheel radius (m); ~0.2 m for electric bike
Cdr = 1.1   % Aerodynamic drag coefficient of the bike and rider (dimensionless) [1]
A   = 0.51  % Frontal area (m^2)
CdA = Cdr*A % Effective frontal area (m^2)
theta = 0;  % Angle of up slope (degree)
theta = theta*pi/180 % Angle of up slope (radian)
g   = 9.81  % Acceleration due to gravity (m/s^2)
rho = 1.2   % Density of air (kg/m^3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N = (Mr+Mb)*g*cos(theta)       % Total normal reaction on both wheels (Newton)
F_roll  = Crr*N                % Total rolling resistance on both wheels (Newton)
F_air   = 0.5*CdA*rho*(v^2)    % Drag force due to aerodynamic drag (Newton)
F_grav  = (Mr+Mb)*g*sin(theta) % Opposing force due to gravity on up slopes (Newton)
F_tract = F_roll+F_air+F_grav  % Total tractive force required (Newton)
P_roll  = F_roll*v             % Power required to overcome rolling resistance (Watt)
P_air   = F_air*v              % Power required to overcome aerodynamic drag (Watt)
P_grav  = F_grav*v             % Power required to overcome gravity on up slopes (Newton)
P_total = P_roll+P_air+P_grav  % Total power required (Watt)
T_rear  = F_tract*Rw           % Required torque in rear wheel (Nm)
T_rider = GR*T_rear            % Torque delivered by prime mover e.g. rider/motor/engine (Nm)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To Do:
% 1. Incorporate effect of headwind / tailwind / crosswind
% 2. Modify the model so as to take some inputs (such as velocity profile of a 
%    complete ride, altitude profile of the ride) and calculate the 
%    instantaneous, peak and average torque and power values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

