clear all
close all
calInMouthtapeallcovered = importfile0219b("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_02_19-02_calInMouth_tape_allcovered.xlsx", "2021_02_19-02_calInMouth_tape_a", [1, 5044]);

%% assign variables
data_elliptical_nodeg = calInMouthtapeallcovered;
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
duration = 6;

figure()
subplot(2,1,1)
plot(t1', pred1)
hold on
yline(0, '--r');
yline(4, '--r');
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, with swallowing")
ylim ([-3 +7]);
xlim([0 duration]);
subplot(2,1,2)
plot(t1',tred1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 duration]);
ylim ([25 45]);

%% filtered signal

pred1nd_nf=data_elliptical_nodeg(121:end,2); %not filtered data

fc = 2; %cutoff freq
fs = 12; %sample freq
[b,a] = butter(5,fc/(fs/2));
pred1nd=filtfilt(b,a,pred1nd_nf);


figure()
subplot(2,1,1)
plot(t1',pred1nd_nf, '--r')
hold on 
plot(t1',pred1nd, 'b');
legend("signal", "filtered signal");
title("SIGNAL AND FILTERED SIGNAL");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([-3 +7]);
xlim([0 duration]);

subplot(2,1,2)
plot(t1',pred1nd_nf, '--r')
hold on 
plot(t1',pred1nd, 'b');
legend("signal", "filtered signal");
title("Enlargement of the signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([-3 +6]);
xlim([3 5]);
