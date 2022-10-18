%% PID Control of Quadcopter Altitude Near Hover
% Acknowledgement: Prof. Peter Seiler
%-------------------------------------------------
%% Vehicle Parameters
close all; clear all;
m = 65e-3;              % Mass, kg
g = 9.81;               % Gravitational constant, m/s^2
%kT = ;          % Thrust coefficient, N
kT = input('Enter the estimated thrust coefficient, N, kT: ');
umax = 500;             % Maximum motor input command, unitless
umin = 0;               % Minimum motor input command, unitless


%% Step change in altitude reference, m
Tf = 25;            % Final simulation time, sec
hdes0 = 0.7;          % Initial altitude, m
hdesf = 1.25;         % Final altitude, m

%% Initial Conditions
h0 = hdes0;        % Initial altitude, m
hdot0 = 0;         % Initial altitude velocity, m/s

%%
hddmax = (4*kT*umax-m*g)/m;    % Maximum upward acceleration, m/s^2


%% PD Control With Gravity Feedforward
% Consider the following PD control law with gravity feedforward
%    u = Kp*(hdes-h) - Kd*hdot + (mhat*g)/(4*kThat)
% Here u is the **individual motor command** input (unitless).  Also,
% (mhat,kThat) indicate that these are estimates used by the controller.
% The parrot drone Simulink diagram uses:5
%    uhat = Kphat*(hdes-h) - Kdhat*hdot + mhat*g
% where uhat is the **total thrust** command (N).  These are related by
%    uhat = (4*kT)*u
% Thus gains computed using the simplified second-order model must be
% scaled by (4*kT) before implementing in the parrot Simulink diagram.
%
% NOTE - An integral gain is included below for testing but this can be
% set to zero to simply to the PD control given above.

% Select Gains -- Gains are specified using simplified second order model
%

GainCase = 2;
switch GainCase
    case 1
        % Select closed-loop natural frequency and damping ratio
        wn = input('Desired natural freq, rad/sec, wn: ');      % Desired natural freq, rad/sec
        zeta = input('Desired damping ratio, unitless, zeta: ' );  % Desired damping ratio, unitless
        
        % Closed-loop ODE with PD control + perfect gravity cancellation:
        %   m hdd = (4*kT)*( Kp*(hdes-h) - Kd*hdot )
        % --> hdd + (4*kT*Kd/m) hdot + (4*kT*Kp/m) h = (4*kT*Kp/m)*hdes
        Kp = wn^2*m/(4*kT);
        Kd = 2*zeta*wn*m/(4*kT);
        Ki = 0;
        
    case 2
        Kp = input('Enter the proportional gain, Kp: ');
        Kd = input('Enter the derivative gain, Kd: ');
        Ki = 0;
        
        wn = sqrt(Kp*4*kT/m)
        zeta = 4*kT*Kd/(2*wn*m)
end

%% Closed-Loop Transfer Function (hdes to h)
% This constructs the closed-loop model from altitude reference to
% altitude. It assumes perfect cancellation of the gravitational force
% by the feedforward term. It also neglects the saturation that limits
% the motor command.

% Plant dynamcs (neglecting gravity term)
%   m d^2(h)/dt^2 = (4*kT)*u
% The state-space model below has input motor command and outputs [h;hdot]
Ag = [0 1; 0 0];
Bg = [0; 4*kT/m];
Cg = eye(2);
Dg = 0;
G = ss(Ag,Bg,Cg,Dg);

tstep = 1;   % Step time, sec
% Controller: PI and D terms
if Ki==0
    Cpi = ss(Kp);
else
    Cpi = tf([Kp Ki],[1 0]);
end
Cd = ss(Kd);

% Form closed-loop from r to h, T
systemnames = 'G Cpi Cd';
inputvar = '[r]';
outputvar = '[G(1)]';
input_to_G = '[Cpi+Cd]';
input_to_Cpi = '[r-G(1)]';
input_to_Cd = '[-G(2)]';
%T = sysic;

if false
    % Code to debug:  Represent controller
    % (*)  u = Kp e + Kd edot + Ki integral(e)
    % The actual implementation only uses rate-feedback, i.e. Kd*edot is
    % replaced by -Kd*hdot.  However, the form in (*) above is much easier
    % to construct with standard functions and will yield the same poles
    % (only the closed-loop zeros will be different)
    Gb = tf(4*kT/m,[1 0 0]);
    if Ki==0
        Cpid = tf([Kd Kp],1);
    else
        Cpid = tf([Kd Kp Ki],[1 0]);
    end
    Tb = feedback(Gb*Cpid,1);
end


%% Simulate Closed-Loop

% Parameter estimates
mhat = m;
kThat = kT;

% Disturbance Force, N
Fd = 0;

% Simulate system

sim('QuadPID',[0 Tf]);

% Plot results
figure(1);
hold on
plot(tsim,h,'b');
xlabel('Time, sec');
ylabel('Altitude, m');
ylim([0.6 1.9])

grid on;

figure(2);
plot(tsim,hdot,'b');
xlabel('Time, sec');
ylabel('Altitude Velocity, m/s');
grid on;

figure(3);
plot(tsim,u,'b');
xlabel('Time, sec');
ylabel('Motor Command, unitless');
grid on;


%% Convert Gains
% There are two sets of gains:
% 1) (Kd,Kp,Ki) for simple second order model with motor command input
% 2) (Kdhat,Kphat,Kihat) for parrot drone simulink model with total
%    thrust command input. These are the gains that should be used in the
%    parrot drone Simulink model.

Kdhat = (4*kT)*Kd;
Kphat = (4*kT)*Kp;
Kihat = (4*kT)*Ki;
