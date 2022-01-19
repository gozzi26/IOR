
close all
clear all
% nitrile
Me_Nitrile_Nose = importfile0304_me1_nit_nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me1_Nitrile_Nose.xlsx", "2021_03_04-Me1_Nitrile_Nose", [2, 4006]);
    Me_Nitrile_Nose = Me_Nitrile_Nose(1:3600,:);
Me_Nitrile_mouthOPENandmothSEMI = importfile0302_openMOUTH("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_02-Me4_mouthOPEN and mothSEMI.xlsx", "2021_03_02-Me4_mouthOPEN and mo", [1, 3776]);
    Me_Nitrile_mouthCOMPLopen = Me_Nitrile_mouthOPENandmothSEMI(121:2020,:);
Me_Nitrile_mouthSEMIopen = importfile0302_me4_semiOpen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_02-Me4_mouthSEMIopen.xlsx", "2021_03_02-Me4_mouthSEMIopen", [89, 2243]);

%exposed
Me_Exp_Nose = importfile_Me2_exposed_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me2_exposed_Nose.xlsx", "2021_03_04-Me2_exposed_Nose", [2, 4480]);
    Me_Exp_Nose = Me_Exp_Nose(1:3900,:);
Me_Exp_SEMIopen = importfile_me3_exp_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me3_exposed_SEMIopen.xlsx", "2021_03_04-Me3_exposed_SEMIopen", [2, 2476]);
    Me_Exp_SEMIopen = Me_Exp_SEMIopen(1:1000,:);
Me_Exp_COMPLopen = importfile_me4_exp_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me4_exposed_COMPLopen.xlsx", "2021_03_04-Me4_exposed_COMPLope", [2, 2817]);
    Me_Exp_COMPLopen = Me_Exp_COMPLopen (1:2000,:);

%Subject 1 - tape
Me_Tape_Nose = importfile_me5_tape_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me5_tape_Nose.xlsx", "2021_03_04-Me5_tape_Nose", [2, 3402]);
    Me_Tape_Nose = Me_Tape_Nose(1:3100,:);
Me_Tape_COMPLopen = importfile_me6_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me6_tape_COMPLopen.xlsx", "2021_03_04-Me6_tape_COMPLopen", [2, 3592]);

Me_Tape_SEMIopen = importfile_Me7_tape_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me7_tape_SEMIopen.xlsx", "2021_03_04-Me7_tape_SEMIopen", [2, 2855]);


%Subject 2 - Veronica
Ver_tape_COMPLopen = importfile_Ver_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_COMPLopen.xlsx", "2021_03_04-Veronica_tape_COMPLo", [2, 2583]);
Ver_tape_Nose = importfile_Ver_tape_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_Nose.xlsx", "2021_03_04-Veronica_tape_Nose", [2, 1469]);
Ver_tape_SEMIopen = importfile_Ver_tape_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_SEMIopen.xlsx", "2021_03_04-Veronica_tape_SEMIop", [2, 2665]);
    Ver_tape_SEMIopen = Ver_tape_SEMIopen(1:2400,:);
    
%Subject 3 - Allison
Alli_tape_Nose = importfile_Alli_tape_close("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_closed.xlsx", "2021_03_04-Allison_tape_closed", [2, 2948]);
    Alli_tape_Nose = Alli_tape_Nose(1:2730,:);
Alli_tape_COMPLopen = importfile_Alli_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_COMPLopen.xlsx", "2021_03_04-Allison_tape_COMPLop", [2, 3037]);
Alli_tape_SEMIopen = importfile_Alli_tape_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_SEMILopen.xlsx", "2021_03_04-Allison_tape_SEMILop", [2, 2331]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 12; %Sample freq

%passband filter
f_min=0.2;
f_max=0.4;
fpass = [f_min f_max];


%graphs
f_lim=[0 f_max+0.2]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% comparison between subjects - Nose Respiration

signal_1= Me_Tape_Nose(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal

signal_2 = Ver_tape_Nose(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal

signal_3 = Alli_tape_Nose(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal

%% signal 1
figure
sgtitle('Comparison between subjects - Nose Respiration')
% subplot (4,3,1) %signal
% plot(t1, signal_1)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject1 - tape")
% ylim ([-5 10]);
% xlim([0 duration1]);
% 
% subplot (4,3,4) %spectrum
% stem(f1,P1_1) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
% xlim([0 fmax1]);

subplot (2,3,1) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Subject1 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,4) %signal filtered spectrum
stem(f1_pbf,P1_1_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% signal 2

% subplot (4,3,2) %signal
% plot(t2, signal_2)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject2 - tape")
% ylim ([-5 10]);
% xlim([0 duration2]);
% 
% subplot (4,3,5) %spectrum
% stem(f2,P1_2) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,2) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Subject2 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,5) %signal filtered spectrum
stem(f2_pbf,P1_2_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% signal 3

% subplot (4,3,3) %signal
% plot(t3, signal_3)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject3 - tape")
% ylim ([-5 10]);
% xlim([0 duration3]);
% 
% subplot (4,3,6) %spectrum
% stem(f3,P1_3) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,3) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Subject3 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,6) %signal filtered spectrum
stem(f3_pbf,P1_3_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);


%% comparison between subjects - Open Mouth Respiration
signal_1= Me_Tape_COMPLopen(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);

pbf_signal_1 = bandpass(signal_1,fpass,Fs); %filtering with edge effet
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal

signal_2 = Ver_tape_COMPLopen(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal

signal_3 = Alli_tape_COMPLopen(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal

%% signal 1
figure
sgtitle('Comparison between subjects - Open Mouth Respiration')
% subplot (4,3,1) %signal
% plot(t1, signal_1)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject1 - tape")
% ylim ([-5 10]);
% xlim([0 duration1]);
% 
% subplot (4,3,4) %spectrum
% stem(f1,P1_1) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,1) %signal filtered
plot(t1,pbf_signal_1, 'b'); %t1,
title("Subject1 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,4) %signal filtered spectrum
stem(f1_pbf,P1_1_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% signal 2

% subplot (4,3,2) %signal
% plot(t2, signal_2)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject2 - tape")
% ylim ([-5 10]);
% xlim([0 duration2]);
% 
% subplot (4,3,5) %spectrum
% stem(f2,P1_2) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,2) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Subject2 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,5) %signal filtered spectrum
stem(f2_pbf,P1_2_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% signal 3

% subplot (4,3,3) %signal
% plot(t3, signal_3)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject3 - tape")
% ylim ([-5 10]);
% xlim([0 duration3]);
% 
% subplot (4,3,6) %spectrum
% stem(f3,P1_3) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,3) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Subject3 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,6) %signal filtered spectrum
stem(f3_pbf,P1_3_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% comparison between subjects - SEMI open Mouth Respiration
signal_1= Me_Tape_SEMIopen(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal

signal_2 = Ver_tape_SEMIopen(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal

signal_3 = Alli_tape_SEMIopen(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal

%% signal 1
figure
sgtitle('Comparison between subjects - Semi Mouth Respiration')
% subplot (4,3,1) %signal
% plot(t1, signal_1)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject1 - tape")
% ylim ([-5 10]);
% xlim([0 duration1]);
% 
% subplot (4,3,4) %spectrum
% stem(f1,P1_1) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,1) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Subject1 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,4) %signal filtered spectrum
stem(f1_pbf,P1_1_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% signal 2

% subplot (4,3,2) %signal
% plot(t2, signal_2)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject2 - tape")
% ylim ([-5 10]);
% xlim([0 duration2]);
% 
% subplot (4,3,5) %spectrum
% stem(f2,P1_2) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,2) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Subject2 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,5) %signal filtered spectrum
stem(f2_pbf,P1_2_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

%% signal 3

% subplot (4,3,3) %signal
% plot(t3, signal_3)
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% title("Subject3 - tape")
% ylim ([-5 10]);
% xlim([0 duration3]);
% 
% subplot (4,3,6) %spectrum
% stem(f3,P1_3) 
% title('Single-Sided Amplitude Spectrum')
% xlabel('f (Hz)')
% ylabel('Power')
% xlim([0 fmax1]);

subplot (2,3,3) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Subject3 - tape - Filtered Signal");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

subplot (2,3,6) %signal filtered spectrum
stem(f3_pbf,P1_3_pbf) 
title('Spectrum of the filtered signal')
xlabel('f (Hz)')
ylabel('Power')
xlim(f_lim);

