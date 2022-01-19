clear all
close all

Me4mouthOPENandmothSEMI = importfile0302_openMOUTH("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_02-Me4_mouthOPEN and mothSEMI.xlsx", "2021_03_02-Me4_mouthOPEN and mo", [1, 3776]);

%% assign variables
data_elliptical_nodeg = Me4mouthOPENandmothSEMI;
data_elliptical = data_elliptical_nodeg;

%% define variables

%calibration
t_call=linspace(0,10,120); %10 seconds for calibration
p_cal1=data_elliptical(1:120,2);
t_cal1=data_elliptical(1:120,1);
p_avg1=mean(p_cal1);
t_avg1=mean(t_cal1);

%Raw signal
t1=linspace(0,(length(data_elliptical)-120)*(1/12)/60,(length(data_elliptical)-120)); 
p_red1=data_elliptical(121:end,2);
t_red1=data_elliptical(121:end,1);
duration = length(p_red1)*(1/12)/60 + 0.1;


%% Calibration
% figure()
% subplot(2,1,1)
% plot(t_call, p_cal1)
% xlabel("time [s]")
% ylabel("atmospheric pressure [cmH2O]");
% hold on 
% yl=yline(p_avg1, '--r','P-avg');
% yl.LabelHorizontalAlignment = 'left';
% title("Calibration")
% 
% subplot(2,1,2)
% plot(t_call,t_cal1)
% yl=yline(t_avg1, '--r','T-avg');
% yl.LabelHorizontalAlignment = 'left';
% xlabel("time [s]")
% ylabel("Temperature [°C]");

%% Raw signal, with swallowing
% figure()
% subplot(2,1,1)
% plot(t1', p_red1)
% hold on
% % yline(3.5, '--r');
% % yline(6.5, '--r');
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Raw signal, with swallowing")
% ylim ([-5 9]);
% xlim([0 duration]);
% subplot(2,1,2)
% plot(t1',t_red1)
% xlabel("time [min]")
% ylabel("Temperature [C]");
% xlim([0 duration]);
% ylim ([25 45]);


%% PROCESSING
mouth_COMPLopen = p_red1(1:1900);
t_Open_mouth=linspace(0,length(mouth_COMPLopen)*(1/12)/60,length(mouth_COMPLopen));

figure
plot(t_Open_mouth,mouth_COMPLopen)
hold on
ylim ([-5 9]);
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Completely OPEN")


%% freq analysis --- mouth_COMPL_open
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%processing
Fs = 12;              % Sampling frequency                    
T = 1/Fs;             % Sampling period        
X = mouth_COMPLopen;   % Signal
L = length(mouth_COMPLopen);  % Length of signal
t = (0:L-1)*T;

Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

figure
stem(f,P1) 
title('Single-Sided Amplitude Spectrum of COMPLopen')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim ([0 1]);

%% PassBand Filter

fpass = [0.1 0.4];
data_passbandfilter = bandpass(X,fpass,Fs);

figure()
plot(t_Open_mouth,data_passbandfilter, 'b');
title("FILTERED SIGNAL");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([-6 +9]);
xlim([0 duration]);

%% final plot
figure
subplot (3,1,1) %signal
plot(t_Open_mouth,mouth_COMPLopen)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal - Complet open mouth Respiration");

subplot (3,1,2) %spectrum
stem(f,P1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim ([0 1]);


subplot (3,1,3)
plot(t_Open_mouth,data_passbandfilter, 'b');
title("Filtered Singal - passband [0.1 0.4] Hz");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
