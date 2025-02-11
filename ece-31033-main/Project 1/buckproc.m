clear;
clc;

%% CIRCUIT PARAMETERS
V_in = 1000;        % Vin = 1000 V
V_out = 750;        % Vout = 750 V
P_light = 50000;    % min of load (50 kW)
P_heavy = 200000;   % max of load (200 kW)
f_sw = 20000;       % switching frequency
T_sw = 1 / f_sw;    % switching period
D = V_out / V_in;   % duty cycle
dV = 7.5;           % ripple voltage
t_end = 2 * T_sw;   % 2 cycles
dt = T_sw / 500;    % time step

%% CIRCUIT CALCULATIONS
R_loadMax = (V_out ^ 2) / P_light;   % 11.25 ohms
R_loadMin = (V_out ^ 2) / P_heavy;   % 2.8125 ohms

L_crit = ((1 - D) * T_sw * R_loadMax) / 2;
L = 1.15 * L_crit;

C = (V_out * T_sw * (1 - D)) / (8 * L * (dV / V_out));

%% SWITCH STATE VARS
t(1) = 0;       % start time
n = 1;          % time index
I_L(1) = 0;     % inductor current
V_C(1) = 0;     % capacitor voltage

buck;

%% Average Computations
avg_I_L = av(I_L, T_sw, dt);
avg_V_C = av(V_C, T_sw, dt);
effi = ((avg_V_C * avg_I_L) / (V_in * avg_I_L)) * 100;

%% PLOTS

disp(['Simulation starting...']);

figure;
subplot(3,1,1);
plot(t * 1000000, states, 'LineWidth', 1.5);
xlabel('Time (microseconds)');
ylabel('Switch State');
title('Transistor Behavior (ON = 1, OFF = 0)');
ylim([-0.1, 1.1]);
grid on;

subplot(3,1,2);
plot(t * 1000000, I_L, 'LineWidth', 1.5);
xlabel('Time (microseconds)');
ylabel('Inductor Current (A)');
title('Inductor Current v. Time');
grid on;

subplot(3,1,3);
plot(t * 1000000, V_C, 'LineWidth', 1.5);
xlabel('Time (microseconds)');
ylabel('Capacitor Voltage (V)');
title('Capacitor Voltage v. Time');
grid on;

disp(['Simulation complete! Efficiency = ', num2str(effi), '%']);
