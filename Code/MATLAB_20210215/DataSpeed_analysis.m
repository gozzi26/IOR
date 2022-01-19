close all
clear all
Subject1_Nose_changetime = readmatrix('2021_03_17_Nose_change_time.xlsx');
Subject1_Nose_changetime_part1 = readmatrix('2021_03_17_Nose_change_time_part1.xlsx');
Subject1_Nose_changetime_part1 = readmatrix('2021_03_17_Nose_change_time_2&2.xlsx');
%% Generic data for the signals
Fs = 12; %Sample freq

% %passband filter
% f_min=0.1;
% f_max=0.4;
% fpass = [f_min f_max];

%lowpass
fpass = 1;

%graphs
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;
%% Graph CHANGE TIME
signal_1= Subject1_Nose_changetime(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = lowpass(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);


figure
sgtitle('Nose respiration - Forced insp and expiration at different speed')

subplot (4,1,1)
plot(t1,signal_1, 'b');
title('Raw Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,1,2) %signal filtered
plot(t1,pbf_signal_1, 'b');
title('Filtered Signal');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,1,3)
stem(f1_pbf,P1_1_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (4,1,4)
%autocorr(signal_5)
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");

begin1 = 95;
begin2 = 559;
begin3 = 1166;
FirstPEAK = signal_1(begin1-56:begin1+200);
t_peak1=linspace(0,(length(FirstPEAK))*(1/12),(length(FirstPEAK)));
SecondPEAK = signal_1(begin2-50:begin2+200);
t_peak2=linspace(0,(length(SecondPEAK))*(1/12),(length(SecondPEAK)));
ThirdPEAK =  signal_1(begin3-50:begin3+200);
t_peak3=linspace(0,(length(ThirdPEAK))*(1/12),(length(ThirdPEAK)));
figure
sgtitle('Data validation: Forced insp and expiration at different speed')
plot (t_peak1,FirstPEAK) %t_peak1,
hold on
plot (t_peak2,SecondPEAK) %t_peak2, 
hold on
plot (t_peak3,ThirdPEAK) %t_peak3, 
hold on
xline(50*(1/12), '--r', 'start IN');
xline(83*(1/12), '--r', 'start EXP');
xline(109*(1/12), '--r', 'end  1sec EXP');
xline(118*(1/12), '--r', 'end  2sec EXP');
xline(128*(1/12), '--r', 'end  3sec EXP');
legend("2secIN + 2secOUT", "2secIN + 3secOUT", "2secIN + 4secOUT");
xlabel("time [sec]")
ylabel("Pressure [cmH2O]");
















