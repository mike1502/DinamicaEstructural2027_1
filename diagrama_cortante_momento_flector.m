%% =========================================================================
% DIAGRAMAS DE CORTANTE Y MOMENTO FLECTOR EN VIGA EN VOLADIZO
% Materia: Mecánica de Materiales / Diseño Estructural
% =========================================================================

clear; clc; close all;

% --- 1. DEFINICIÓN DE VARIABLES (VALORES UTILIZADOS) ---
L = 600;      % Longitud de la viga en centímetros (cm)
P = 5000;     % Fuerza puntual en el extremo libre en kilogramos-fuerza (kgf)

% --- 2. VECTOR DE DISTANCIA ---
x = linspace(0, L, 1000);

% --- 3. CÁLCULO DE CORTANTE (V) Y MOMENTO (M) ---
V = P * ones(size(x));          
M = -P * (L - x);               

% --- 4. GRAFICACIÓN DE LOS DIAGRAMAS ---
fig = figure('Name', 'Análisis Estructural de Viga en Voladizo', 'NumberTitle', 'off');

% --- Subplot 1: Diagrama de Fuerza Cortante (V) ---
subplot(2,1,1);
plot(x, V, 'b-', 'LineWidth', 2.5);
hold on;
plot([0 0], [0 P], 'b-', 'LineWidth', 2.5);
plot([L L], [P 0], 'b-', 'LineWidth', 2.5);
plot([0 L], [0 0], 'k--', 'LineWidth', 1); 

title('Diagrama de Fuerza Cortante (V)', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Distancia desde el empotramiento, x (cm)', 'FontSize', 10);
ylabel('Cortante, V (kgf)', 'FontSize', 10);
xlim([-20, L + 20]);
ylim([-500, P + 500]);
grid on;
text(L/2, P*1.05, sprintf('V = %d kgf', P), 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

% --- Subplot 2: Diagrama de Momento Flector (M) ---
subplot(2,1,2);
plot(x, M, 'r-', 'LineWidth', 2.5);
hold on;
plot([0 L], [0 0], 'k--', 'LineWidth', 1); 

title('Diagrama de Momento Flector (M)', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Distancia desde el empotramiento, x (cm)', 'FontSize', 10);
ylabel('Momento, M (kgf·cm)', 'FontSize', 10);
xlim([-20, L + 20]);
ylim([min(M) - 300000, 300000]);
grid on;

text(5, min(M), sprintf('M_{máx} = %s kgf·cm', fill_commas(min(M))), 'VerticalAlignment', 'top', 'FontWeight', 'bold');
text(L-40, 150000, 'M = 0', 'FontWeight', 'bold');

% --- 5. GUARDAR LA FIGURA EN ALTA CALIDAD ---
% 'print' guarda la figura actual. El parámetro '-dpng' especifica el formato PNG
% y '-r300' fuerza la resolución a 300 DPI (alta calidad para documentos).
print(fig, 'documento_diagramas.png', '-dpng', '-r300');


% --- FUNCIÓN AUXILIAR LOCAL PARA FORMATO DE NÚMEROS ---
function str = fill_commas(num)
    str = num2str(num, '%0.0f');
end

