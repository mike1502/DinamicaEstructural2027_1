% =========================================================================
% RESPUESTA DINÁMICA DE VIGA EN VOLADIZO (1 GDL) - GRÁFICOS INDEPENDIENTES
% Historias de tiempo de Desplazamiento, Cortante y Momento por separado
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
k = (3 * E * I) / (L^3);                    
peso_viga_total = peso_metro * L;
W_efectivo = P + 0.23 * peso_viga_total;     
m = W_efectivo / g;                         

w = sqrt(k / m);                            
c = 2 * psi * m * w;                        
wd = sqrt(k/m - (c / (2*m))^2);             
u_est = P / k;                              

A_const = -u_est;                           
B_const = -u_est * c / (2 * m * wd);        

% --- 3. VECTOR DE TIEMPO Y RESPUESTA EN EL TIEMPO ---
t = linspace(0, 10, 2000); 
u_dinamico = exp(-c/(2*m) * t) .* (A_const * cos(wd * t) + B_const * sin(wd * t)) + u_est;

% Cálculo de fuerzas internas dinámicas y estáticas en el empotramiento
F_dinamica_equiv = k * u_dinamico;          
V_din = F_dinamica_equiv;                   
M_din = -F_dinamica_equiv * L;              

V_est = P;
M_est = -P * L;

% --- 4. VENTANA 1: DESPLAZAMIENTO DINÁMICO ---
fig1 = figure('Name', 'Desplazamiento Dinamico', 'NumberTitle', 'off');
plot(t, u_dinamico, 'b-', 'LineWidth', 2, 'DisplayName', 'Dinámico u(t)');
hold on;
plot([0 10], [u_est u_est], 'r--', 'LineWidth', 1.5, 'DisplayName', 'Estático');
title('Historia de Desplazamiento en el Extremo Libre', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Tiempo, t (segundos)', 'FontSize', 10);
ylabel('Desplazamiento, u (cm)', 'FontSize', 10);
grid on; legend('Location', 'best');
text(0.5, u_est * 1.1, sprintf('u_{est} = %0.2f cm', u_est), 'Color', 'r', 'FontWeight', 'bold');
text(0.35, max(u_dinamico) * 1.03, sprintf('u_{máx,din} = %0.2f cm', max(u_dinamico)), 'Color', 'b', 'FontWeight', 'bold');
print(fig1, '1_desplazamiento_dinamico.png', '-dpng', '-r300');

% --- 5. VENTANA 2: FUERZA CORTANTE ---
fig2 = figure('Name', 'Fuerza Cortante', 'NumberTitle', 'off');
plot(t, V_din, 'b-', 'LineWidth', 2, 'DisplayName', 'Dinámico V(t)');
hold on;
plot([0 10], [V_est V_est], 'r--', 'LineWidth', 1.5, 'DisplayName', 'Estático');
title('Historia de Fuerza Cortante en el Empotramiento', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Tiempo, t (segundos)', 'FontSize', 10);
ylabel('Fuerza Cortante, V (kgf)', 'FontSize', 10);
grid on; legend('Location', 'best');
text(0.5, V_est * 1.1, sprintf('V_{est} = %d kgf', V_est), 'Color', 'r', 'FontWeight', 'bold');
text(0.35, max(V_din) * 1.03, sprintf('V_{máx,din} = %0.0f kgf', max(V_din)), 'Color', 'b', 'FontWeight', 'bold');
print(fig2, '2_fuerza_cortante_dinamica.png', '-dpng', '-r300');

% --- 6. VENTANA 3: MOMENTO FLECTOR ---
fig3 = figure('Name', 'Momento Flector', 'NumberTitle', 'off');
plot(t, M_din / 1e6, 'm-', 'LineWidth', 2, 'DisplayName', 'Dinámico M(t)');
hold on;
plot([0 10], [M_est M_est] / 1e6, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Estático');
title('Historia de Momento Flector en el Empotramiento', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Tiempo, t (segundos)', 'FontSize', 10);
ylabel('Momento Flector, M (\times10^6 kgf·cm)', 'FontSize', 10);
grid on; legend('Location', 'best');
text(0.5, (M_est / 1e6) - 0.3, sprintf('M_{est} = %0.1f\\times10^6 kgf\\cdotcm', M_est/1e6), 'Color', 'r', 'FontWeight', 'bold');
text(0.35, (min(M_din) / 1e6) - 0.3, sprintf('M_{mín,din} = %0.1f\\times10^6 kgf\\cdotcm', min(M_din)/1e6), 'Color', 'm', 'FontWeight', 'bold');
print(fig3, '3_momento_flector_dinamico.png', '-dpng', '-r300');
