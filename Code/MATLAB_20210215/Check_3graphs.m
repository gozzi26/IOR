close all
clear all

% Signal_closed = readmatrix('2021_03_15-Me_Tape_Nose.xlsx');
% Signal_openMouth = readmatrix('2021_03_15-Me_Tape_OpenMouth.xlsx');
% Signal_SEMIopenMouth = readmatrix('2021_03_15-Me_Tape_SEMIOpenMouth.xlsx');
% Signal_SEMIopenMouth = Signal_SEMIopenMouth(142:end,:);

% Signal_closed = readmatrix('2021_03_15-Allison_Tape_Nose.xlsx');
% Signal_openMouth = readmatrix('2021_03_15-Allison_Tape_OpenMouth.xlsx');
% Signal_SEMIopenMouth = readmatrix('2021_03_15-Allison_Tape_SEMIOpenMouth.xlsx');

% Signal_closed = readmatrix('2021_03_15-Ver_Tape_Nose.xlsx');
%     Signal_closed = Signal_closed (1:1592,:);
% Signal_openMouth = readmatrix('2021_03_15-Ver_Tape_OpenMouth.xlsx');
% Signal_SEMIopenMouth = readmatrix('2021_03_15-Ver_Tape_SEMIOpenMouth.xlsx');
%     Signal_SEMIopenMouth = Signal_SEMIopenMouth(1000:end,:);
    
Signal_closed = readmatrix('2021_03_11-Man_Tape_Nose.xlsx');
    Signal_closed = Signal_closed (43:2500,:);
Signal_openMouth = readmatrix('2021_03_11-Man_Tape_openmouth.xlsx');
    Signal_openMouth = Signal_openMouth (50:2350,:);
Signal_SEMIopenMouth = readmatrix('2021_03_11-Man_Tape_SEMIopenmouth.xlsx');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 12; %Sample freq

%passband filter
f_min=0.1;
f_max=0.4;
fpass = [f_min f_max];


%graphs
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

signal_1= Signal_closed(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Signal_openMouth(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Signal_SEMIopenMouth(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% signal 1
figure
%sgtitle('3 graphs')

subplot (3,3,1) %signal filtered
plot(t1,signal_1, 'b');
title("Nose Respiration");
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (3,3,4)
plot(t1,pbf_signal_1) 
title('Filtered Signal - PassBand Filter [0.1 - 0.4]Hz')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");


subplot (3,3,7)
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);
%% signal 2

subplot (3,3,2) %signal
plot(t2,signal_2, 'r');
title("Open Mouth Respiration");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

subplot (3,3,5) %signal filtered 
plot(t2,pbf_signal_2) 
title('Filtered Signal - PassBand Filter [0.1 - 0.4]Hz')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (3,3,8) 
plot(t_freq_RR_2,freq_RR_permin_MovAvg_2);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 3

subplot (3,3,3) %signal
plot(t3,signal_3, 'k');
title("Semi Open Mouth Respiration");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

subplot (3,3,6) %signal filtered 
plot(t3,pbf_signal_3) 
title('Filtered Signal - PassBand Filter [0.1 - 0.4]Hz')
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

subplot (3,3,9) 
plot(t_freq_RR_3,freq_RR_permin_MovAvg_3);
title("Respiratory Rate");
xlabel("time [sec]");
ylabel("Breaths per minute");
ylim ([5 25]);