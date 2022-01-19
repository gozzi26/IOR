close all
clear all

% subject1 - Alessandro
Subject1_closed = readmatrix('2021_03_15-Me_Tape_Nose.xlsx');
Subject1_openMouth = readmatrix('2021_03_15-Me_Tape_OpenMouth.xlsx');
Subject1_SEMIopenMouth = readmatrix('2021_03_15-Me_Tape_SEMIOpenMouth.xlsx');
    Subject1_SEMIopenMouth = Subject1_SEMIopenMouth(142:end,:);
Subject1_openMouth_noseclipped = readmatrix('2021_03_18_OpenMoth_NoseClipped.xlsx');
Subject1_SEMIopenMouth_noseclipped = readmatrix('2021_03_18_SEMIOpenMoth_NoseClipped_trial1.xlsx');
    
Subject1_changingRR = readmatrix('2021_03_16_RR_2.xlsx');
    Subject1_changingRR = Subject1_changingRR(50:end-200,:);
Subject1_ForcedINSPandEXP = readmatrix('2021_03_16_RR_3_Max insp_and_exp.xlsx');

Subject1_ForcedINSPandEXP_Nose = readmatrix('2021_03_16_RR_3_Max insp_and_exp_long.xlsx');
Subject1_ForcedINSPandEXP_SEMIopenmouth = readmatrix('2021_03_16_RR_3_Max insp_and_exp_SEMIopen.xlsx');
Subject1_ForcedINSPandEXP_openmouth = readmatrix('2021_03_16_RR_3_Max insp_and_exp_open.xlsx');
Subject1_Nose_changetime = readmatrix('2021_03_17_Nose_change_time.xlsx');

%subject2 - Allison
Subject2_closed = readmatrix('2021_03_15-Allison_Tape_Nose.xlsx');
Subject2_openMouth = readmatrix('2021_03_15-Allison_Tape_OpenMouth.xlsx');
Subject2_SEMIopenMouth = readmatrix('2021_03_15-Allison_Tape_SEMIOpenMouth.xlsx');

%subject3 - Veronica
Subject3_closed = readmatrix('2021_03_15-Ver_Tape_Nose.xlsx');
    Subject3_closed = Subject3_closed (300:1592,:);
Subject3_openMouth = readmatrix('2021_03_15-Ver_Tape_OpenMouth.xlsx');
Subject3_SEMIopenMouth = readmatrix('2021_03_15-Ver_Tape_SEMIOpenMouth.xlsx');
    Subject3_SEMIopenMouth = Subject3_SEMIopenMouth(1000:end,:);
    
%subject4 - Manuela
Subject4_closed = readmatrix('2021_03_17_Man_Tape_Nose.xlsx');
    Subject4_closed = Subject4_closed (310:end,:);
Subject4_openMouth = readmatrix('2021_03_17_Man_Tape_open.xlsx');
Subject4_SEMIopenMouth = readmatrix('2021_03_17_Man_Tape_SEMIopen.xlsx');


%% Generic data for the signals
Fs = 12; %Sample freq

% %passband filter
% f_min=0.1;
% f_max=0.4;
% fpass = [f_min f_max];

%lowpass
fpass = 0.6;

%highpass
f_highf = 0.05;

%graphs
t_lim =[0.8 1.8];
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;
n_lag = 15;

%% Graph 1 - Comparison between different modes on the same subject
signal_1= Subject1_closed(:,2);
[P1_1,f1] = freq_analysis(signal_1);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
signal_1_nodrift = highpass(signal_1,f_highf,Fs);
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1_nodrift,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);


signal_2 = Subject1_openMouth_noseclipped(:,2);
[P1_2,f2] = freq_analysis(signal_2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
signal_2_nodrift = highpass(signal_2,f_highf,Fs);
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2_nodrift,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);


signal_3 = Subject1_SEMIopenMouth_noseclipped(:,2);
[P1_3,f3] = freq_analysis(signal_3);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
signal_3_nodrift = highpass(signal_3,f_highf,Fs);
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3_nodrift,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);


figure
sgtitle('Comparison between different modes')

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

%semi open mouth
subplot (2,3,3)
plot(t3,signal_3);
title('Raw Signal - SemiOpen Mouth Oral Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (2,3,6)
plot(t3,pbf_signal_3);
title('Filtered Signal - SemiOpen Mouth Oral Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);


%% Graph 2 - Autocorrelation

figure
sgtitle('Autocorrelation')

%nose
subplot (2,3,1)
plot(t1,pbf_signal_1);
title('Filtered Signal - Nasal Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (2,3,4)
[c,lags] = xcorr(signal_1_nodrift,signal_1_nodrift,n_lag,'normalized');
stem(lags,c)
title('Autocorrelation - Nasal Breathing');
xlabel("Lag");
ylabel("Sample Autocorrelation");

%open mouth
subplot (2,3,2)
plot(t2,pbf_signal_2);
title('Filtered Signal - Open Mouth Oral Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (2,3,5)
[c,lags] = xcorr(signal_2_nodrift,signal_2_nodrift,n_lag,'normalized');
stem(lags,c)
title('Autocorrelation - Open Mouth Oral Breathing');
xlabel("Lag");
ylabel("Sample Autocorrelation");


%semi open mouth
subplot (2,3,3)
plot(t3,pbf_signal_3);
title('Filtered Signal - SemiOpen Mouth Oral Breathing');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);


subplot (2,3,6)
[c,lags] = xcorr(signal_3_nodrift,signal_3_nodrift,n_lag,'normalized');
stem(lags,c)
title('Autocorrelation - SemiOpen Mouth Oral Breathing');
xlabel("Lag");
ylabel("Sample Autocorrelation");



%% Graph 3 - comparison between different subjects - open
signal_1= Subject1_openMouth(:,2);
signal_1_nodrift = highpass(signal_1,f_highf,Fs);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Subject2_openMouth(:,2);
signal_2_nodrift = highpass(signal_2,f_highf,Fs);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Subject3_openMouth(:,2);
signal_3_nodrift = highpass(signal_3,f_highf,Fs);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);

signal_4 = Subject4_openMouth(:,2);
signal_4_nodrift = highpass(signal_4,f_highf,Fs);
t4=linspace(0,(length(signal_4))*(1/12)/60,(length(signal_4)));
pbf_signal_4 = removeEdgeEffect_and_filter (signal_4,fpass,Fs);
[P1_4_pbf,f4_pbf] = freq_analysis(pbf_signal_4);  %freq_analysis of the filtered signal
[t_freq_RR_4,freq_RR_permin_MovAvg_4] = RemovePress_CountBreath(pbf_signal_4);


%% signal 1
figure
sgtitle('Comparison between different subjects - OpenMouth Oral and Nasal Breathing')

subplot (4,2,1) %signal filtered
plot(t1,pbf_signal_1);
title('Filtered Signal - Subj 1 - Open Mouth B');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (4,2,2)
[c,lags] = xcorr(signal_1_nodrift,signal_1_nodrift,n_lag,'normalized');
stem(lags,c)
title('Sample autocorrelation function - Open Mouth B');
xlabel("Lag");
ylabel("Sample Autocorrelation");

%% signal 2
subplot (4,2,3) %signal filtered
plot(t2,pbf_signal_2);
title('Filtered Signal - Subj 2 - Open Mouth B');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (4,2,4)
[c,lags] = xcorr(signal_2_nodrift,signal_2_nodrift,n_lag,'normalized');
stem(lags,c)
title('Sample autocorrelation function - Open Mouth B');
xlabel("Lag");
ylabel("Sample Autocorrelation");


%% signal 3
subplot (4,2,5) %signal filtered
plot(t3,pbf_signal_3);
title('Filtered Signal - Subj 3 - Open Mouth B');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (4,2,6)
[c,lags] = xcorr(signal_3_nodrift,signal_3_nodrift,n_lag,'normalized');
stem(lags,c)
title('Sample autocorrelation function - Open Mouth B');
xlabel("Lag");
ylabel("Sample Autocorrelation");

%% signal 4
subplot (4,2,7) %signal filtered
plot(t4,pbf_signal_4);
title('Filtered Signal - Subj 4 - Open Mouth B');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (t_lim);

subplot (4,2,8)
[c,lags] = xcorr(signal_4_nodrift,signal_4_nodrift,n_lag,'normalized');
stem(lags,c)
title('Sample autocorrelation function - Open Mouth B');
xlabel("Lag");
ylabel("Sample Autocorrelation");

