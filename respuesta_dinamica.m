% =========================================================================
% RESPUESTA DINÁMICA DE VIGA EN VOLADIZO (1 GDL) - FORMULACIÓN TEÓRICA
% Ecuación de movimiento con variables explícitas c, w, wd, A y B
% =========================================================================

clear; clc; close all;

% --- 1. DATOS DEL PROBLEMA ---
L = 600;                % Longitud (cm)
P = 5000;               % Fuerza puntual en el extremo (kgf)
E = 2040000;            % Módulo de Elasticidad del acero (kgf/cm^2)
I = 14152;              % Momento de Inercia de la viga IR 356x50.6 (cm^4)
peso_metro = 50.6/100;  % Peso propio de la viga en kgf/cm
g = 981;                % Aceleración de la gravedad (cm/s^2)
psi = 0.05;             % Fracción de amortiguamiento (5%)

% --- 2. CÁLCULO DE CONSTANTES FÍSICAS ---
k = (3 * E * I) / (L^3);                    % Rigidez lateral de la viga
peso_viga_total = peso_metro * L;
W_efectivo = P + 0.23 * peso_viga_total;     % Peso efectivo (Puntual + 23% viga)
m = W_efectivo / g;                         % Masa equivalente

% --- 3. APLICACIÓN DE TUS FÓRMULAS ---
w = sqrt(k / m);                            % Frecuencia angular natural (rad/s)
c = 2 * psi * m * w;                        % Coeficiente de amortiguamiento físico
wd = sqrt(k/m - (c / (2*m))^2);             % Frecuencia amortuguada dentro de la raíz

u_est = P / k;                              % Desplazamiento estático (12.47 cm)

% Constantes de integración por condiciones iniciales u(0)=0, du(0)=0
A_const = -u_est;                           
B_const = -u_est * c / (2 * m * wd);        

% --- 4. VECTOR DE TIEMPO Y RESPUESTA DINÁMICA ---
t = linspace(0, 10, 2000); % De 0 a 10 segundos

% Ecuación estructural exacta solicitada
u_dinamico = exp(-c/(2*m) * t) .* (A_const * cos(wd * t) + B_const * sin(wd * t)) + u_est;

% --- 5. GRAFICACIÓN DE LA RESPUESTA ---
fig_dinamica = figure('Name', 'Respuesta Dinámica Dinámica 1 GDL', 'NumberTitle', 'off');

plot(t, u_dinamico, 'b-', 'LineWidth', 2);
hold on;
plot([0 10], [u_est u_est], 'r--', 'LineWidth', 1.5); % Línea del valor estático

title('Respuesta Dinámica en el Extremo Libre (1 GDL)', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Tiempo, t (segundos)', 'FontSize', 10);
ylabel('Desplazamiento, u(t) (cm)', 'FontSize', 10);
xlim([0, 10]);
grid on;

% Anotaciones de los puntos clave
text(0.5, u_est * 1.1, sprintf('u_{est} = %0.2f cm', u_est), 'Color', 'r', 'FontWeight', 'bold');
text(0.35, max(u_dinamico) * 1.03, sprintf('u_{máx,din} = %0.2f cm', max(u_dinamico)), 'Color', 'b', 'FontWeight', 'bold');

% --- 6. GUARDAR LA FIGURA EN ALTA CALIDAD ---
print(fig_dinamica, 'respuesta_dinamica_exacta.png', '-dpng', '-r300');

% --- 7. DESPLIEGUE DE RESULTADOS EN CONSOLA ---
fprintf('--- VARIABLES INTERNAS DEL MODELO ---\n');
fprintf('Frecuencia natural (w): %0.4f rad/s\n', w);
fprintf('Coeficiente de amortiguamiento (c): %0.4f kgf·s/cm\n', c);
fprintf('Frecuencia amortiguada (wd): %0.4f rad/s\n', wd);
fprintf('Constante A: %0.4f\n', A_const);
fprintf('Constante B: %0.4f\n', B_const);
