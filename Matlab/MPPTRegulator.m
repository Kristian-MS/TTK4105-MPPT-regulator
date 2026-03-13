
% Konstanter

a = 20;
b = 40;
w = 0;

n = 0.2;
Vt = 10;
ad = 1/(n*Vt);

I_L = 5;
I_0 = 1e-2;

V_MMP = 9;

K_P = 0.5;
K_i = 5;

R_s = 10;
R_sh = 100;

v = linspace(0,15,500);
i = I_L - I_0*(exp(v/(n*Vt))-1);
P = v.*i;

figure(5)
plot(v,P), grid on
xlabel('v [V]')
ylabel('P [W]')

figure(1)
plot(out.v.Data, out.P.Data)
xlabel("v [V]", "Fontsize", 15)
ylabel("P [W]", "Fontsize", 15)
legend("PV-kurve", "Fontsize", 12)
grid on

figure(2)
plot(out.i.Data, out.v.Data)
xlabel("i [A]", "Fontsize", 15)
ylabel("v [V]", "Fontsize", 15)
legend("IV-kurve", "Fontsize", 12)
grid on

figure(3)
plot(out.v.Time, out.v.Data)
xlabel("t [s]", "Fontsize", 15)
ylabel("v [V]", "Fontsize", 15)
legend("V", "Fontsize", 12)
grid on

figure(4)
plot(out.i.Time, out.i.Data)
xlabel("t [s]", "Fontsize", 15)
ylabel("i [A]", "Fontsize", 15)
legend("i", "Fontsize", 12)
grid on