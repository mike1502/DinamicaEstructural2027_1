% =========================================================================
% Replicación de la Figura 10 (Túnel de Viento - Casa FL-27) en MATLAB
% =========================================================================

clear; clc; close all;

% 1. Definición de la lista de sensores (Eje X)
sensors = {'2','3','5','6','7','9','10','11','12','13','15','16','17','18','19','20','21','22','23','24','28'};
x = 1:length(sensors);

% 2. Declaración de variables numéricas (Valores representativos de la Fig. 10)
cp_mean_130     = [-0.10, -0.15, -0.22, -0.20, -0.21, -0.12, -0.10, -0.08, -0.25, -0.22, -0.23, -0.21, -0.11, -0.06, -0.08, -0.09, -0.14, -0.08, -0.10, -0.12, -0.12];
cp_std_130      = [0.08, 0.08, 0.14, 0.10, 0.11, 0.08, 0.07, 0.06, 0.12, 0.11, 0.11, 0.11, 0.05, 0.06, 0.06, 0.05, 0.06, 0.07, 0.07, 0.08, 0.06];
cp_peak_neg_130 = [-0.55, -0.52, -1.18, -1.02, -1.03, -0.85, -0.73, -0.48, -1.48, -1.52, -1.38, -0.42, -0.53, -0.42, -0.40, -0.45, -0.72, -0.92, -0.53, -0.50, -0.48];
cp_peak_pos_130 = [0.35, 0.22, 0.25, 0.30, 0.32, 0.38, 0.28, 0.32, 0.35, 0.28, 0.28, 0.22, 0.25, 0.38, 0.32, 0.30, 0.28, 0.42, 0.48, 0.32, 0.32];

% Envolventes para todas las direcciones (0° a 350°)
cp_env_neg_all  = [-2.20, -2.00, -1.85, -1.80, -2.35, -2.30, -2.30, -1.40, -2.85, -3.28, -3.00, -2.20, -2.25, -1.60, -2.28, -2.12, -1.80, -2.85, -1.50, -1.52, -2.28];
cp_env_pos_all  = [0.45, 0.38, 0.35, 0.58, 0.55, 0.68, 0.58, 0.78, 0.40, 0.78, 0.98, 0.75, 0.92, 0.80, 0.80, 0.72, 0.68, 0.40, 0.30, 0.55, 0.50];

% 3. Crear la ventana de la figura
figure('Position', [100, 100, 950, 500], 'Color', 'w');
hold on;

% 4. Dibujar el sombreado de fondo para agrupar zonas de sensores
groups = [1 2; 6 8; 11 12; 15 17; 21 21];
for i = 1:size(groups, 1)
    patch([groups(i,1)-0.4, groups(i,2)+0.4, groups(i,2)+0.4, groups(i,1)-0.4], ...
        [-5, -5, 2, 2], [0.9, 0.94, 1], 'EdgeColor', 'none', 'HandleVisibility', 'off');
end

% 5. Eje izquierdo: Coeficiente de Presión (Cp)
yyaxis left
plot(x, cp_env_pos_all, 'r:^', 'MarkerFaceColor', 'none'); hold on;
plot(x, cp_env_neg_all, 'r:d', 'MarkerFaceColor', 'none');
plot(x, cp_peak_pos_130, 'k+');
plot(x, cp_peak_neg_130, 'kx');
plot(x, cp_mean_130, 'k_', 'LineWidth', 1.5, 'MarkerSize', 8);

ylabel('Pressure Coefficient Cp', 'FontWeight', 'bold');
ylim([-5.0, 2.0]);
ax = gca; 
ax.YColor = 'k';

% 6. Eje derecho: Desviación Estándar (STD of Cp)
yyaxis right
plot(x, cp_std_130, 'ko', 'MarkerFaceColor', 'none');

ylabel('STD of Cp', 'FontWeight', 'bold');
ylim([0.0, 0.7]);
ax.YColor = 'k';

% 7. Formato y etiquetas finales
set(gca, 'XTick', x, 'XTickLabel', sensors);
xlabel('Sensor Number', 'FontWeight', 'bold');
grid on;
title('Replicación Figura 10: Túnel de Viento (FL-27)', 'FontSize', 12);