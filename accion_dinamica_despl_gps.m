%% Replicación de la Figura 2b (M. Celebi, 2000)
clear; clc; close all;

% 1. Parámetros del sistema y frecuencia de muestreo
fs = 10;                     % 10 Hz (muestras/segundo)
t = 0 : (1/fs) : 70;         % Vector de tiempo (0 a 70 s)

f_n = 0.245;                 % Frecuencia fundamental (Hz)
omega_n = 2 * pi * f_n;      % Frecuencia angular (rad/s)
zeta = 0.02;                 % 2% de amortiguamiento
omega_d = omega_n * sqrt(1 - zeta^2);

% 2. Ruido y offsets ambientales
rng(42);
offset_NS = 50.0; offset_EW = 0.0;
ruido_NS = offset_NS + 5.0 * sin(2*pi*f_n*t) + 1.0 * randn(size(t));
ruido_EW = offset_EW + 5.0 * sin(2*pi*f_n*t) + 1.0 * randn(size(t));

% 3. Liberación y respuesta transitoria amortiguada
t0 = 24.5; 
idx = (t >= t0);
t_evt = t(idx) - t0;
decaimiento = exp(-zeta * omega_n * t_evt);

% Oscilaciones en fase y asimétricas por excentricidad del GPS
osc_NS = -45.0 * decaimiento .* cos(omega_d * t_evt + pi/6);
osc_EW = -50.0 * decaimiento .* cos(omega_d * t_evt + pi/6);

displ_NS = ruido_NS; displ_EW = ruido_EW;
displ_NS(idx) = displ_NS(idx) + osc_NS;
displ_EW(idx) = displ_EW(idx) + osc_EW;

% 4. Gráfica
figure
plot(t, displ_NS, 'k-', 'LineWidth', 1.2); hold on;
plot(t, displ_EW, 'k-', 'LineWidth', 1.2);
text(54, 78, 'NS', 'FontSize', 12, 'FontWeight', 'bold');
text(54, 15, 'EW', 'FontSize', 12, 'FontWeight', 'bold');
xlim(); ylim([-50 100]);
xlabel('TIME (S)', 'FontWeight', 'bold'); ylabel('DISPL. [CM]', 'FontWeight', 'bold');
title('(b) TIME-HISTORY FROM GPS', 'FontWeight', 'bold');
grid on; set(gca, 'GridLineStyle', ':', 'GridAlpha', 0.7);