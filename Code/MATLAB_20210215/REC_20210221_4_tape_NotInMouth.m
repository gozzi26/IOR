clear all
close all
tapenotinMouth = importfile0221d("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_02_21-04_tape_notinMouth.xlsx", "2021_02_21-04_tape_notinMouth", [130, 4384]);

%% assign variables
data_elliptical_nodeg = tapenotinMouth;
data_elliptical = data_elliptical_nodeg;

%% Raw signal, with swallowing

t1=linspace(0,(length(data_elliptical)-120)*(1/12)/60,(length(data_elliptical)-120)); 
pred1=data_elliptical(121:end,2);
tred1=data_elliptical(121:end,1);
duration = 3.3;

figure()
subplot(2,1,1)
plot(t1', pred1)
hold on
yline(0.8, '--r');
yline(1.8, '--r');
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, sensor tape covered not in the mouth")
ylim ([-1 +3.5]);
xlim([0.1 3]);
subplot(2,1,2)
plot(t1',tred1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([1 1.5]);

