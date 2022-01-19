clear all
close all
tapeinsideplasticcupdentalgluenocall = importfile0223a("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_02_23-04_tapeinside_plasticcup_dentalglue_nocall.xlsx", "2021_02_23-04_tapeinside_plasti", [1, 7901]);

%% assign variables
data_elliptical_nodeg = tapeinsideplasticcupdentalgluenocall;
data_elliptical = data_elliptical_nodeg;

%% Calibration

t=linspace(0,10,120); %10 seconds for calibration
pcal1=data_elliptical(1:120,2);
tcal1=data_elliptical(1:120,1);
pavg1=mean(pcal1);
tavg1=mean(tcal1);

figure()
subplot(2,1,1)
plot(t', pcal1)
xlabel("time [s]")
ylabel("atmospheric pressure [cmH2O]");
hold on 
yl=yline(pavg1, '--r','P-avg');
yl.LabelHorizontalAlignment = 'left';
title("Calibration")
subplot(2,1,2)
plot(t',tcal1)
yl=yline(tavg1, '--r','T-avg');
yl.LabelHorizontalAlignment = 'left';
xlabel("time [s]")
ylabel("Temperature [C]");
%% Raw signal, with swallowing

t1=linspace(0,(length(data_elliptical)-120)*(1/12)/60,(length(data_elliptical)-120)); 
pred1=data_elliptical(121:end,2);
tred1=data_elliptical(121:end,1);
duration = 10;

figure()
subplot(2,1,1)
plot(t1', pred1)
hold on
% yline(0, '--r');
% yline(4, '--r');
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, with swallowing")
ylim ([-3 +8]);
xlim([0 duration]);
subplot(2,1,2)
plot(t1',tred1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 duration]);
ylim ([25 45]);