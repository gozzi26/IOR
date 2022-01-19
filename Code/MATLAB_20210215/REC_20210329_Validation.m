
close all
clear all
Subject1_closed_maskON = readmatrix('2021_03_15-Me_Tape_Nose.xlsx');
Subject1_closed_maskOFF = readmatrix('2021_03_29_Nose_nomask.xlsx');

Subject1_SEMIopenMouth_noseclipped_maskON = readmatrix('2021_03_18_SEMIOpenMoth_NoseClipped_trial1.xlsx');
Subject1_SEMIopenMouth_noseclipped_maskOFF = readmatrix('2021_03_29_SEMIOpenMoth_NoseClipped_nomask.xlsx');

Subject1_NOSEin_MouthOUT = readmatrix('2021_03_29_NOSEin_MouthOUT.xlsx');

%% Generic data for the signals
Fs = 12; %Sample freq

% %passband filter
% f_min=0.1;
% f_max=0.4;
% fpass = [f_min f_max];

%lowpass
fpass = 0.6;

%hipass
f_highf = 0.05;

%graphs
t_lim =[0.8 1.8];
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;
n_lag = 15;

%% comparison between mask and no mask
signal_1= Subject1_closed_maskON(:,2);
signal_1_nodrift = highpass(signal_1,f_highf,Fs);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Subject1_closed_maskOFF(:,2);
signal_2_nodrift = highpass(signal_2,f_highf,Fs);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

figure
sgtitle('Nasal respiration - ')

%nose
subplot (2,3,1)
plot(t1,signal_1);
title('Raw Signal - Nasal Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (2,3,4)
plot(t1,pbf_signal_1);
title('Filtered Signal - Nasal Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

%open mouth
subplot (2,3,2)
plot(t2,signal_2);
title('Raw Signal - Open Mouth Oral Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (2,3,5)
plot(t2,pbf_signal_2);
title('Filtered Signal - Open Mouth Oral Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);


