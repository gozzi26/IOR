close all
clear all

% subject1 - Alessandro
Subject1_closed = readmatrix('2021_03_15-Me_Tape_Nose.xlsx');
Subject1_openMouth = readmatrix('2021_03_15-Me_Tape_OpenMouth.xlsx');
Subject1_SEMIopenMouth = readmatrix('2021_03_15-Me_Tape_SEMIOpenMouth.xlsx');
    Subject1_SEMIopenMouth = Subject1_SEMIopenMouth(142:end,:);
    
Subject1_changingRR = readmatrix('2021_03_16_RR_2.xlsx');
    Subject1_changingRR = Subject1_changingRR(50:end-200,:);
Subject1_ForcedINSPandEXP = readmatrix('2021_03_16_RR_3_Max insp_and_exp.xlsx');

Subject1_ForcedINSPandEXP_Nose = readmatrix('2021_03_16_RR_3_Max insp_and_exp_long.xlsx');
Subject1_ForcedINSPandEXP_SEMIopenmouth = readmatrix('2021_03_16_RR_3_Max insp_and_exp_SEMIopen.xlsx');
Subject1_ForcedINSPandEXP_openmouth = readmatrix('2021_03_16_RR_3_Max insp_and_exp_open.xlsx');
Subject1_Nose_changetime = readmatrix('2021_03_17_Nose_change_time.xlsx');

% subject2 - Allison
Subject2_closed = readmatrix('2021_03_15-Allison_Tape_Nose.xlsx');
Subject2_openMouth = readmatrix('2021_03_15-Allison_Tape_OpenMouth.xlsx');
Subject2_SEMIopenMouth = readmatrix('2021_03_15-Allison_Tape_SEMIOpenMouth.xlsx');

%subject3 - Veronica
Subject3_closed = readmatrix('2021_03_15-Ver_Tape_Nose.xlsx');
    Subject3_closed = Subject3_closed (300:1592,:);
Subject3_openMouth = readmatrix('2021_03_15-Ver_Tape_OpenMouth.xlsx');
Subject3_SEMIopenMouth = readmatrix('2021_03_15-Ver_Tape_SEMIOpenMouth.xlsx');
    Subject3_SEMIopenMouth = Subject3_SEMIopenMouth(1000:end,:);
    
%subject4 - Manuela - DA CAMBIARE
Subject4_closed = readmatrix('2021_03_17_Man_Tape_Nose.xlsx');
    Subject4_closed = Subject4_closed (310:end,:);
Subject4_openMouth = readmatrix('2021_03_17_Man_Tape_open.xlsx');
Subject4_SEMIopenMouth = readmatrix('2021_03_17_Man_Tape_SEMIopen.xlsx');

%subject5 - Hyro - DA CAMBIARE
Subject5_closed = readmatrix('2021_03_15-Allison_Tape_Nose.xlsx');
Subject5_openMouth = readmatrix('2021_03_15-Allison_Tape_OpenMouth.xlsx');
Subject5_SEMIopenMouth = readmatrix('2021_03_15-Allison_Tape_SEMIOpenMouth.xlsx');


%% Generic data for the signals
Fs = 12; %Sample freq

% %passband filter
% f_min=0.1;
% f_max=0.4;
% fpass = [f_min f_max];

%lowpass
fpass = 0.3;

%graphs
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;

%% Graph 1 - comparison between different modes in the same subject
signal_1= Subject1_closed(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Subject1_openMouth(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Subject1_SEMIopenMouth(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);



%% signal 1
figure
sgtitle('Comparison between different modes in the same subject')

subplot (4,3,1)
plot(t1,signal_1, 'b');
title('Raw Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,3,4) %signal filtered
plot(t1,pbf_signal_1, 'b');
title('Filtered Signal');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,3,7)
stem(f1_pbf,P1_1_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (4,3,10)
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 2

subplot (4,3,2)
plot(t2,signal_2, 'b');
title('Raw Signal - Subject 1 - OpenMouth');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,3,5) %signal filtered
plot(t2,pbf_signal_2, 'b');
title('Filtered Signal');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,3,8)
stem(f2_pbf,P1_2_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (4,3,11)
% [c,lags] = xcorr(signal_3,signal_3,1000,'normalized');
% stem(lags,c)
autocorr(signal_2)

%% signal 3

subplot (4,3,3)
plot(t3,signal_3, 'b');
title('Raw Signal - Subject 1 - SEMIOpenMouth');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,3,6) %signal filtered
plot(t3,pbf_signal_3, 'b');
title('Filtered Signal');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (4,3,9)
stem(f3_pbf,P1_3_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (4,3,12)
plot(t_freq_RR_3,freq_RR_permin_MovAvg_3);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% Graph 2 - comparison between different subjects - Nose
signal_1= Subject1_closed(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Subject2_closed(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Subject3_closed(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);

signal_4 = Subject4_closed(:,2);
t4=linspace(0,(length(signal_4))*(1/12)/60,(length(signal_4)));
pbf_signal_4 = removeEdgeEffect_and_filter (signal_4,fpass,Fs);
[P1_4_pbf,f4_pbf] = freq_analysis(pbf_signal_4);  %freq_analysis of the filtered signal
[t_freq_RR_4,freq_RR_permin_MovAvg_4] = RemovePress_CountBreath(pbf_signal_4);

signal_5 = Subject5_closed(:,2);
t5=linspace(0,(length(signal_5))*(1/12)/60,(length(signal_5)));
pbf_signal_5 = removeEdgeEffect_and_filter (signal_5,fpass,Fs);
[P1_5_pbf,f5_pbf] = freq_analysis(pbf_signal_5);  %freq_analysis of the filtered signal
[t_freq_RR_5,freq_RR_permin_MovAvg_5] = RemovePress_CountBreath(pbf_signal_5);

%% signal 1
figure
sgtitle('comparison between different subjects - Nose Respiration')

subplot (5,3,1) %signal filtered
plot(t1,pbf_signal_1, 'b');
title('Filtered Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,2)
stem(f1_pbf,P1_1_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,3)
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 2
subplot (5,3,4) %signal filtered
plot(t2,pbf_signal_2, 'b');
title('Filtered Signal - Subject 2 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,5)
stem(f2_pbf,P1_2_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,6)
plot(t_freq_RR_2,freq_RR_permin_MovAvg_2);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 3
subplot (5,3,7) %signal filtered
plot(t3,pbf_signal_3, 'b');
title('Filtered Signal - Subject 3 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,8)
stem(f3_pbf,P1_3_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,9)
plot(t_freq_RR_3,freq_RR_permin_MovAvg_3);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 4
subplot (5,3,10) %signal filtered
plot(t4,pbf_signal_4, 'b');
title('Filtered Signal - Subject 4 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,11)
stem(f4_pbf,P1_4_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,12)
plot(t_freq_RR_4,freq_RR_permin_MovAvg_4);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 5
subplot (5,3,13) %signal filtered
plot(t5,pbf_signal_5, 'b');
title('Filtered Signal - Subject 5 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,14)
stem(f5_pbf,P1_5_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,15)
plot(t_freq_RR_5,freq_RR_permin_MovAvg_5);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% Graph 3 - comparison between different subjects - SEMIopen
signal_1= Subject1_SEMIopenMouth(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Subject2_SEMIopenMouth(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Subject3_SEMIopenMouth(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);

signal_4 = Subject4_SEMIopenMouth(:,2);
t4=linspace(0,(length(signal_4))*(1/12)/60,(length(signal_4)));
pbf_signal_4 = removeEdgeEffect_and_filter (signal_4,fpass,Fs);
[P1_4_pbf,f4_pbf] = freq_analysis(pbf_signal_4);  %freq_analysis of the filtered signal
[t_freq_RR_4,freq_RR_permin_MovAvg_4] = RemovePress_CountBreath(pbf_signal_4);

signal_5 = Subject5_SEMIopenMouth(:,2);
t5=linspace(0,(length(signal_5))*(1/12)/60,(length(signal_5)));
pbf_signal_5 = removeEdgeEffect_and_filter (signal_5,fpass,Fs);
[P1_5_pbf,f5_pbf] = freq_analysis(pbf_signal_5);  %freq_analysis of the filtered signal
[t_freq_RR_5,freq_RR_permin_MovAvg_5] = RemovePress_CountBreath(pbf_signal_5);

%% signal 1
figure
sgtitle('Comparison between different subjects - SEMIopen Mouth Respiration')

subplot (5,3,1) %signal filtered
plot(t1,pbf_signal_1, 'b');
title('Filtered Signal - Subject 1 - SEMIopen');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,2)
stem(f1_pbf,P1_1_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,3)
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 2
subplot (5,3,4) %signal filtered
plot(t2,pbf_signal_2, 'b');
title('Filtered Signal - Subject 2 - SEMIopen');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,5)
stem(f2_pbf,P1_2_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,6)
plot(t_freq_RR_2,freq_RR_permin_MovAvg_2);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 3
subplot (5,3,7) %signal filtered
plot(t3,pbf_signal_3, 'b');
title('Filtered Signal - Subject 3 - SEMIopen');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,8)
stem(f3_pbf,P1_3_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,9)
plot(t_freq_RR_3,freq_RR_permin_MovAvg_3);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 4
subplot (5,3,10) %signal filtered
plot(t4,pbf_signal_4, 'b');
title('Filtered Signal - Subject 4 - SEMIopen');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,11)
stem(f4_pbf,P1_4_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,12)
plot(t_freq_RR_4,freq_RR_permin_MovAvg_4);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

%% signal 5
subplot (5,3,13) %signal filtered
plot(t5,pbf_signal_5, 'b');
title('Filtered Signal - Subject 5 - SEMIopen');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,14)
stem(f5_pbf,P1_5_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,15)
plot(t_freq_RR_5,freq_RR_permin_MovAvg_5);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);


%% Graph 3 - comparison between different subjects - open
signal_1= Subject1_openMouth(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Subject2_openMouth(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Subject3_openMouth(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);

signal_4 = Subject4_openMouth(:,2);
t4=linspace(0,(length(signal_4))*(1/12)/60,(length(signal_4)));
pbf_signal_4 = removeEdgeEffect_and_filter (signal_4,fpass,Fs);
[P1_4_pbf,f4_pbf] = freq_analysis(pbf_signal_4);  %freq_analysis of the filtered signal
[t_freq_RR_4,freq_RR_permin_MovAvg_4] = RemovePress_CountBreath(pbf_signal_4);

signal_5 = Subject5_openMouth(:,2);
t5=linspace(0,(length(signal_5))*(1/12)/60,(length(signal_5)));
pbf_signal_5 = removeEdgeEffect_and_filter (signal_5,fpass,Fs);
[P1_5_pbf,f5_pbf] = freq_analysis(pbf_signal_5);  %freq_analysis of the filtered signal
[t_freq_RR_5,freq_RR_permin_MovAvg_5] = RemovePress_CountBreath(pbf_signal_5);

%% signal 1
figure
sgtitle('Comparison between different subjects - open Mouth Respiration')

subplot (5,3,1) %signal filtered
plot(t1,pbf_signal_1, 'b');
title('Filtered Signal - Subject 1 - open');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,2)
stem(f1_pbf,P1_1_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,3)
autocorr(signal_1)
% plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
% title("Respiratory Rate");
% xlabel("time [sec]")
% ylabel("Breaths per minute");
% ylim ([5 25]);

%% signal 2
subplot (5,3,4) %signal filtered
plot(t2,pbf_signal_2, 'b');
title('Filtered Signal - Subject 2 - open');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,5)
stem(f2_pbf,P1_2_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,6)
autocorr(signal_2)
% plot(t_freq_RR_2,freq_RR_permin_MovAvg_2);
% title("Respiratory Rate");
% xlabel("time [sec]")
% ylabel("Breaths per minute");
% ylim ([5 25]);

%% signal 3
subplot (5,3,7) %signal filtered
plot(t3,pbf_signal_3, 'b');
title('Filtered Signal - Subject 3 - open');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,8)
stem(f3_pbf,P1_3_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,9)
autocorr(signal_3)
% plot(t_freq_RR_3,freq_RR_permin_MovAvg_3);
% title("Respiratory Rate");
% xlabel("time [sec]")
% ylabel("Breaths per minute");
% ylim ([5 25]);

%% signal 4
subplot (5,3,10) %signal filtered
plot(t4,pbf_signal_4, 'b');
title('Filtered Signal - Subject 4 - open');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,11)
stem(f4_pbf,P1_4_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,12)
autocorr(signal_4)
% plot(t_freq_RR_4,freq_RR_permin_MovAvg_4);
% title("Respiratory Rate");
% xlabel("time [sec]")
% ylabel("Breaths per minute");
% ylim ([5 25]);

%% signal 5
subplot (5,3,13) %signal filtered
plot(t5,pbf_signal_5, 'b');
title('Filtered Signal - Subject 5 - open');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (5,3,14)
stem(f5_pbf,P1_5_pbf) 
title('Filtered signal Spectrum')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");
xlim (f_lim);

subplot (5,3,15)
autocorr(signal_5)
% plot(t_freq_RR_5,freq_RR_permin_MovAvg_5);
% title("Respiratory Rate");
% xlabel("time [sec]")
% ylabel("Breaths per minute");
% ylim ([5 25]);


%% Graph - Change RR

signal_1= Subject1_changingRR(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);


figure
sgtitle('Data Validation - Respiratory Rate Variation')

subplot (3,1,1)
plot(t1,signal_1, 'b');
title('Raw Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (3,1,2) %signal filtered
plot(t1,pbf_signal_1, 'b');
title('Filtered Signal');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

% subplot (4,1,3)
% stem(f1_pbf,P1_1_pbf) 
% title('Filtered signal Spectrum')
% xlabel("time [min]");
% ylabel("Pressure [cmH2O]");
% xlim (f_lim);

subplot (3,1,3)
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Instantaneous Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");
yl=yline(4, '--r', '4b/min');
yl.LabelHorizontalAlignment = 'left';
yl=yline(6, '--r', '6b/min');
yl.LabelHorizontalAlignment = 'left';
yl=yline(12, '--r', '12b/min');
yl.LabelHorizontalAlignment = 'left';
yl=yline(15, '--r', '15b/min');
yl.LabelHorizontalAlignment = 'left';
ylim ([-2 18]);


%% Graph FAST and SLOW manuevres - Nose
signal_1= Subject1_ForcedINSPandEXP_Nose(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);


figure
sgtitle('fast and slow Manuevre - NOSE')

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
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");

%% Graph FAST and SLOW manuevres - SEMIopen mouth
signal_1= Subject1_ForcedINSPandEXP_SEMIopenmouth (:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);


figure
sgtitle('fast and slow Manuevre - SEMIopen mouth')

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
plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
title("Respiratory Rate");
xlabel("time [sec]")
ylabel("Breaths per minute");


%% Graph FAST and SLOW manuevres - open mouth
signal_1= Subject1_ForcedINSPandEXP_openmouth (:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);


figure
sgtitle('fast and slow Manuevre - open mouth')

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
autocorr(signal_5)
% plot(t_freq_RR_1,freq_RR_permin_MovAvg_1);
% title("Respiratory Rate");
% xlabel("time [sec]")
% ylabel("Breaths per minute");

%% Graph CHANGE TIME
signal_1= Subject1_Nose_changetime(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter(signal_1,fpass,Fs);
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
