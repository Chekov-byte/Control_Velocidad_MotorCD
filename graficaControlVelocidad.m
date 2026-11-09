%% Control de velocidad de un motor de CD.
%  Es importante que el archivo TXT con los datos esté en el mismo 
%  directorio de este Script. El nombre del archivo TXT deber el mismo que
%  está en la función fopen.
clc;
fid=fopen('datosVelocidad5.txt','r'); % Cambie el nombre del archivo si es necesario
datos=fscanf(fid, '%f', [3 inf]);     % datos tiene 3 columnas (variables)
fclose(fid);

v_deseada=datos(1,:)';
v_crudo=datos(2,:)';
control=datos(3,:)';

t=0.005*(0:1:length(control)-1)';

v = v_crudo;%*(2*3.1416/500);

% Filtrado Digital (Media Móvil)
% El filtro promedia puntos adyacentes
ventanas = 20; % Experimenta cambiando este valor (ej. 5, 10, 20)
v_filtrada1 = movmean(v, ventanas);
v_filtrada2 = smoothdata(v);
[v_filtrada3,winsize] = smoothdata(v,"gaussian");

figure(1)
plot(t,v_deseada,'k-','Linewidth',2)
hold on
plot(t,v_crudo,'b-','Linewidth',2)
% hold on
% plot(t,v_filtrada1,'b-','Linewidth',2)
% hold on
% plot(t,v_filtrada2,'r-','Linewidth',2)
% hold on
% plot(t,v_filtrada3,'g-','Linewidth',2)
xlabel('t [s]')
ylabel('v [rad/s]')
legend('Referencia', 'Velocidad');
grid on

figure(2)
plot(t,control,'k-','Linewidth',2)
xlabel('t [s]')
ylabel('Control [V]')
legend('Señal de control');
grid on