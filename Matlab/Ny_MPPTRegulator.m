
% Konstanter

a = 20;
b = 40;
w = 0;

n = 0.2;
Vt = 10;
ad = 1/(n*Vt);

I_L = 5;
I_0 = 1e-4;

V_MMP = 15.5;

K_P = 0.5;
K_i = 5;

R_s = 0.2;
R_sh = 500;
R_sh_inv = 1/R_sh;

R_N = 0.4;

tau = 10^(-5);

v = linspace(0,20,500);
i = I_L - I_0*(exp(v/(n*Vt))-1);
P = v.*i;

i2 = I_L -I_0*(exp((v+i*R_s)/(n*Vt))-1) - (v+i*R_s)/R_sh;
i3 = I_L -I_0*(exp((v+i*R_N)/(n*Vt))-1) - (v+i*R_N)/R_sh;
P2 = v.*i2;
P3 = v.*i3;

figure(5)
plot(v,P), grid on
xlabel('v [V]')
ylabel('P [W]')

figure(6)
plot(v, P2)
hold on
plot(v, P3)
grid on
xlabel('v [V]')
ylabel('P [W]')

%% Comparison plots: Feedback vs Feedforward

% Extract data
t_v  = out.v.Time;
v_fb = out.v.Data;
v_ff = out.v_FF.Data;

t_i  = out.i.Time;
i_fb = out.i.Data;
i_ff = out.i_FF.Data;

t_p  = out.P.Time;
p_fb = out.P.Data;
p_ff = out.P_FF.Data;

% Create figure with tiled layout
figure(10)
tiledlayout(3,1, "TileSpacing","compact", "Padding","compact")

% ---------------- Voltage ----------------
nexttile
plot(t_v, v_fb, 'LineWidth', 2)
hold on
plot(t_v, v_ff, '--', 'LineWidth', 2)
grid on
ylabel('Voltage [V]', 'FontSize', 13)
title('Voltage comparison: Feedback vs Feedforward', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)

% ---------------- Current ----------------
nexttile
plot(t_i, i_fb, 'LineWidth', 2)
hold on
plot(t_i, i_ff, '--', 'LineWidth', 2)
grid on
ylabel('Current [A]', 'FontSize', 13)
title('Current comparison: Feedback vs Feedforward', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)

% ---------------- Power ----------------
nexttile
plot(t_p, p_fb, 'LineWidth', 2)
hold on
plot(t_p, p_ff, '--', 'LineWidth', 2)
grid on
xlabel('Time [s]', 'FontSize', 13)
ylabel('Power [W]', 'FontSize', 13)
title('Power comparison: Feedback vs Feedforward', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)