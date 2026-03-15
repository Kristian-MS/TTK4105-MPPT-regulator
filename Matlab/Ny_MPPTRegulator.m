
%% Konstanter ----------------------

a = 20;
b = 40;
w = 0;

n = 0.2;
Vt = 10;
ad = 1/(n*Vt);

I_L = 5;
I_0 = 1e-4;

% IRRADAINCE
G_ref = 1/1000;
tG = [0 2 4 6 8]';
G  = [1000 1000 1000 300 300]';
G_signal = timeseries(G,tG);

% MPP fra plot
V_MMP = 13.7;

% FB variabler
K_P = 0.5;
K_i = 5;

% Motstand variabler
R_s = 0.2;
R_sh = 500;
R_sh_inv = 1/R_sh;

R_N = 0.8; %For å gjøre FF dårligere (dobbeltsjekk om er i sim)

tau = 10^(-5); %For å beregne strøm i diode model (derivere)


%% SIM AV DIODE MODEL ----------------------------

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
legend('R_s', 'R_N')

%% Comparison plots: Feedback vs Feedforward (NO irradiance disturbance)

% Extract data - no irradiance disturbance
t_v  = out.v_FB.Time;
v_fb = out.v_FB.Data;
v_ff = out.v_FF.Data;

t_i  = out.i_FB.Time;
i_fb = out.i_FB.Data;
i_ff = out.i_FF.Data;

t_p  = out.P_FB.Time;
p_fb = out.P_FB.Data;
p_ff = out.P_FF.Data;

figure(10)
tiledlayout(3,1, "TileSpacing","compact", "Padding","compact")

% ---------------- Voltage ----------------
nexttile
plot(t_v, v_fb, 'LineWidth', 2)
hold on
plot(out.v_FF.Time, v_ff, '--', 'LineWidth', 2)
grid on
ylabel('Voltage [V]', 'FontSize', 13)
title('Voltage comparison: Feedback vs Feedforward (no irradiance disturbance)', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)

% ---------------- Current ----------------
nexttile
plot(t_i, i_fb, 'LineWidth', 2)
hold on
plot(out.i_FF.Time, i_ff, '--', 'LineWidth', 2)
grid on
ylabel('Current [A]', 'FontSize', 13)
title('Current comparison: Feedback vs Feedforward (no irradiance disturbance)', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)

% ---------------- Power ----------------
nexttile
plot(t_p, p_fb, 'LineWidth', 2)
hold on
plot(out.P_FF.Time, p_ff, '--', 'LineWidth', 2)
grid on
xlabel('Time [s]', 'FontSize', 13)
ylabel('Power [W]', 'FontSize', 13)
title('Power comparison: Feedback vs Feedforward (no irradiance disturbance)', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)


%% Comparison plots: Feedback vs Feedforward (WITH irradiance disturbance)

% Extract data - with irradiance disturbance
t_v_irr  = out.v_FB_irr.Time;
v_fb_irr = out.v_FB_irr.Data;
v_ff_irr = out.v_FF_irr.Data;

t_i_irr  = out.i_FB_irr.Time;
i_fb_irr = out.i_FB_irr.Data;
i_ff_irr = out.i_FF_irr.Data;

t_p_irr  = out.P_FB_irr.Time;
p_fb_irr = out.P_FB_irr.Data;
p_ff_irr = out.P_FF_irr.Data;

figure(11)
tiledlayout(4,1, "TileSpacing","compact", "Padding","compact")

% ---------------- Irradiance ----------------
nexttile
plot(tG, G, 'LineWidth', 2)
grid on
ylabel('G [W/m^2]', 'FontSize', 13)
title('Irradiance disturbance', 'FontSize', 14)
set(gca, 'FontSize', 12)

% ---------------- Voltage ----------------
nexttile
plot(t_v_irr, v_fb_irr, 'LineWidth', 2)
hold on
plot(out.v_FF_irr.Time, v_ff_irr, '--', 'LineWidth', 2)
grid on
ylabel('Voltage [V]', 'FontSize', 13)
title('Voltage comparison: Feedback vs Feedforward (with irradiance disturbance)', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)

% ---------------- Current ----------------
nexttile
plot(t_i_irr, i_fb_irr, 'LineWidth', 2)
hold on
plot(out.i_FF_irr.Time, i_ff_irr, '--', 'LineWidth', 2)
grid on
ylabel('Current [A]', 'FontSize', 13)
title('Current comparison: Feedback vs Feedforward (with irradiance disturbance)', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)

% ---------------- Power ----------------
nexttile
plot(t_p_irr, p_fb_irr, 'LineWidth', 2)
hold on
plot(out.P_FF_irr.Time, p_ff_irr, '--', 'LineWidth', 2)
grid on
xlabel('Time [s]', 'FontSize', 13)
ylabel('Power [W]', 'FontSize', 13)
title('Power comparison: Feedback vs Feedforward (with irradiance disturbance)', 'FontSize', 14)
legend('Feedback', 'Feedforward', 'Location', 'best')
set(gca, 'FontSize', 12)


%% Print data

vFF_end = out.v_FF.Data(end);
iFF_end = out.i_FF.Data(end);
pFF_end = out.P_FF.Data(end);

vFB_end = out.v_FB.Data(end);
iFB_end = out.i_FB.Data(end);
pFB_end = out.P_FB.Data(end);

disp('--- Final values, no irradiance disturbance ---')
fprintf('FF: V = %.4f V, I = %.4f A, P = %.4f W\n', vFF_end, iFF_end, pFF_end);
fprintf('FB: V = %.4f V, I = %.4f A, P = %.4f W\n', vFB_end, iFB_end, pFB_end);

vFFirr_end = out.v_FF_irr.Data(end);
iFFirr_end = out.i_FF_irr.Data(end);
pFFirr_end = out.P_FF_irr.Data(end);

vFBirr_end = out.v_FB_irr.Data(end);
iFBirr_end = out.i_FB_irr.Data(end);
pFBirr_end = out.P_FB_irr.Data(end);

disp('--- Final values, with irradiance disturbance ---')
fprintf('FF irr: V = %.4f V, I = %.4f A, P = %.4f W\n', vFFirr_end, iFFirr_end, pFFirr_end);
fprintf('FB irr: V = %.4f V, I = %.4f A, P = %.4f W\n', vFBirr_end, iFBirr_end, pFBirr_end);

figure(20)
plot(v, P3, 'LineWidth', 2)
hold on
plot(out.v_FF.Data, out.P_FF.Data, '--', 'LineWidth', 1.5)
plot(out.v_FB.Data, out.P_FB.Data, '-', 'LineWidth', 1.5)
grid on
xlabel('v [V]')
ylabel('P [W]')
legend('Static PV curve (plant with R_N)', 'FF trajectory', 'FB trajectory', 'Location', 'best')
title('Operating trajectories on PV curve')


%% CHAT SITT PLOT AV PV-KURVE

v = linspace(0,20,500);
i2 = zeros(size(v));
i3 = zeros(size(v));

for k = 1:length(v)
    vk = v(k);

    f2 = @(ii) I_L - I_0*(exp((vk + ii*R_s)/(n*Vt)) - 1) - (vk + ii*R_s)/R_sh - ii;
    f3 = @(ii) I_L - I_0*(exp((vk + ii*R_N)/(n*Vt)) - 1) - (vk + ii*R_N)/R_sh - ii;

    i2(k) = fzero(f2, I_L);
    i3(k) = fzero(f3, I_L);
end

P2 = v .* i2;
P3 = v .* i3;

figure(21)
plot(v, P2, 'LineWidth', 2)
hold on
plot(v, P3, 'LineWidth', 2)
grid on
xlabel('v [V]')
ylabel('P [W]')
legend('R_s plant', 'R_N plant', 'Location', 'best')
title('Exact PV curves')