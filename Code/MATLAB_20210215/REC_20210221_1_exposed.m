clear all 
close all
calInMouthexposed = importfile("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_02_21-01_calInMouth_exposed.xlsx", "2021_02_21-01_calInMouth_expose", [1, 1026]);

%% assign variables
data_elliptical_nodeg = calInMouthexposed;
data_elliptical = data_elliptical_nodeg;

%% Raw signal, with swallowing

t1=linspace(0,(length(data_elliptical)-120)*(1/12)/60,(length(data_elliptical)-120)); 
pred1=data_elliptical(121:end,2);
tred1=data_elliptical(121:end,1);
duration = 1.3;

figure()
subplot(2,1,1)
plot(t1', pred1)
hold on
yline(0, '--r');
yline(4, '--r');
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, sensor exposed")
%ylim ([-3 +7]);
xlim([0 duration]);
subplot(2,1,2)
plot(t1',tred1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 duration]);
ylim ([25 45]);
