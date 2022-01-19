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
%tape
Me_Tape_Nose = importfile_me5_tape_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me5_tape_Nose.xlsx", "2021_03_04-Me5_tape_Nose", [2, 3402]);
    Me_Tape_Nose = Me_Tape_Nose(1:3100,:);
Me_Tape_COMPLopen = importfile_me6_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me6_tape_COMPLopen.xlsx", "2021_03_04-Me6_tape_COMPLopen", [2, 3592]);

Me_Tape_SEMIopen = importfile_Me7_tape_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Me7_tape_SEMIopen.xlsx", "2021_03_04-Me7_tape_SEMIopen", [2, 2855]);


%Veronica
Ver_tape_COMPLopen = importfile_Ver_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_COMPLopen.xlsx", "2021_03_04-Veronica_tape_COMPLo", [2, 2583]);
Ver_tape_Nose = importfile_Ver_tape_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_Nose.xlsx", "2021_03_04-Veronica_tape_Nose", [2, 1469]);
Ver_tape_SEMIopen = importfile_Ver_tape_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_SEMIopen.xlsx", "2021_03_04-Veronica_tape_SEMIop", [2, 2665]);
    Ver_tape_SEMIopen = Ver_tape_SEMIopen(1:2400,:);
    
%Allison
Alli_tape_Nose = importfile_Alli_tape_close("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_closed.xlsx", "2021_03_04-Allison_tape_closed", [2, 2948]);
    Alli_tape_Nose = Alli_tape_Nose(1:2730,:);
Alli_tape_COMPLopen = importfile_Alli_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_COMPLopen.xlsx", "2021_03_04-Allison_tape_COMPLop", [2, 3037]);
Alli_tape_SEMIopen = importfile_Alli_tape_SEMIopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_SEMILopen.xlsx", "2021_03_04-Allison_tape_SEMILop", [2, 2331]);


%% raw data

%t=linspace(0,(length(signal)-120)*(1/12)/60,(length(signal)));

%% freq analysis
% % nitrile
% [P1_Me_Nitrile_Nose,f_Me_Nitrile_Nose] = freq_analysis(Me_Nitrile_Nose);
% [P1_Me_Nitrile_mouthCOMPLopen,f_Me_Nitrile_mouthCOMPLopen] = freq_analysis(Me_Nitrile_mouthCOMPLopen);
% [P1_Me_Nitrile_mouthSEMIopen,f_Me_Nitrile_mouthSEMIopen] = freq_analysis(Me_Nitrile_mouthSEMIopen);
% %exposed
% [P1_Me_Exp_Nose,f_Me_Exp_Nose] = freq_analysis(Me_Exp_Nose);
% [P1_Me_Exp_SEMIopen,f_Me_Exp_SEMIopen] = freq_analysis(Me_Exp_SEMIopen);
% [P1_Me_Exp_COMPLopen,f_Me_Exp_COMPLopen] = freq_analysis(Me_Exp_COMPLopen);
% %tape
% [P1_Me_Tape_Nose,f_Me_Tape_Nose] = freq_analysis(Me_Tape_Nose);
% [P1_Me_Tape_COMPLopen,f_Me_Tape_COMPLopen] = freq_analysis(Me_Tape_COMPLopen);
% [P1_Me_Tape_SEMIopen,f_Me_Tape_SEMIopen] = freq_analysis(Me_Tape_SEMIopen);
% %Veronica
% [P1_Ver_tape_COMPLopen,f_Ver_tape_COMPLopen] = freq_analysis(Ver_tape_COMPLopen);
% [P1_Ver_tape_Nose,f_Ver_tape_Nose] = freq_analysis(Ver_tape_Nose);
% [P1_Ver_tape_SEMIopen,f_Ver_tape_SEMIopen] = freq_analysis(Ver_tape_SEMIopen);
% 
% %% filtered data
% fpass = [0.1 0.4];
% Fs=12;
% %nitrile
% pbf_Me_Nitrile_Nose = bandpass(Me_Nitrile_Nose,fpass,Fs);
% pbf_Me_Nitrile_mouthCOMPLopen = bandpass(Me_Nitrile_mouthCOMPLopen,fpass,Fs);
% pbf_Me_Nitrile_mouthSEMIopen = bandpass(Me_Nitrile_mouthSEMIopen,fpass,Fs);
% %exposed
% pbf_Me_Exp_Nose = bandpass(Me_Exp_Nose,fpass,Fs);
% pbf_Me_Exp_SEMIopen = bandpass(Me_Exp_SEMIopen,fpass,Fs);
% pbf_Me_Exp_COMPLopen = bandpass(Me_Exp_COMPLopen,fpass,Fs);
% %tape
% pbf_Me_Tape_Nose = bandpass(Me_Tape_Nose,fpass,Fs);
% pbf_Me_Tape_COMPLopen = bandpass(Me_Tape_COMPLopen,fpass,Fs);
% pbf_Me_Tape_SEMIopen = bandpass(Me_Tape_SEMIopen,fpass,Fs);
% %Veronica
% pbf_Ver_tape_COMPLopen = bandpass(Ver_tape_COMPLopen,fpass,Fs);
% pbf_Ver_tape_Nose = bandpass(Ver_tape_Nose,fpass,Fs);
% pbf_Ver_tape_SEMIopen = bandpass(Ver_tape_SEMIopen,fpass,Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fs=12;

%passband filter
f_min = 0.1;
f_max = 0.4;
fpass = [f_min f_max];


%graphs
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;



%% comparison between materials - Nose Respiration


signal_1= Me_Nitrile_Nose(:,2);
t1=linspace(0,(length(signal_1)-120)*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

[pks,index] = findpeaks(pbf_signal_1(400:end-360),t1(400:end-360),'MinPeakDistance',0.07);
mean_peak_1 = mean(pks);

signal_2 = Me_Exp_Nose(:,2);
t2=linspace(0,(length(signal_2)-120)*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

[pks,index] = findpeaks(pbf_signal_2(400:end-360),t2(400:end-360),'MinPeakDistance',0.07);
mean_peak_2 = mean(pks);

signal_3 = Me_Tape_Nose(:,2);
t3=linspace(0,(length(signal_3)-120)*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

[pks,index] = findpeaks(pbf_signal_3(400:end-360),t3(400:end-360),'MinPeakDistance',0.06);
mean_peak_3 = mean(pks);

%% signal 1
figure
sgtitle('Comparison between materials - Nose Respiration')
subplot (3,3,1) %signal
plot(t1, signal_1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Nitrile covering - Nose resp")
ylim ([-5 10]);
xlim([0 duration1]);


subplot (3,3,4) %spectrum
stem(f1,P1_1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,7) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);
hold on
yline(mean_peak_1, '--r');

%% signal 2

subplot (3,3,2) %signal
plot(t2, signal_2)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Exposed - Nose Resp")
ylim ([-5 10]);
xlim([0 duration2]);

subplot (3,3,5) %spectrum
stem(f2,P1_2) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,8) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);
hold on
yline(mean_peak_2, '--r');

%% signal 3

subplot (3,3,3) %signal
plot(t3, signal_3)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Polyimide - Nose Resp")
ylim ([-5 10]);
xlim([0 duration3]);

subplot (3,3,6) %spectrum
stem(f3,P1_3) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,9) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);
hold on
yline(mean_peak_3, '--r');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% comparison between materials - Mouth Open

signal_1= Me_Nitrile_mouthCOMPLopen(:,2);
t1=linspace(0,(length(signal_1)-120)*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

signal_2 = Me_Exp_COMPLopen(:,2);
t2=linspace(0,(length(signal_2)-120)*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

signal_3 = Me_Tape_COMPLopen(:,2);
t3=linspace(0,(length(signal_3)-120)*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

%% signal 1
figure
sgtitle('Comparison between materials - Mouth Completely Open')
subplot (3,3,1) %signal
plot(t1, signal_1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Nitrile")
ylim ([-5 10]);
xlim([0 duration1]);

subplot (3,3,4) %spectrum
stem(f1,P1_1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,7) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");


%% signal 2

subplot (3,3,2) %signal
plot(t2, signal_2)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Exposed")
ylim ([-5 10]);
xlim([0 duration2]);

subplot (3,3,5) %spectrum
stem(f2,P1_2) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,8) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
%ylim ([ylimmin ylimmax]);

%% signal 3

subplot (3,3,3) %signal
plot(t3, signal_3)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Tape")
ylim ([-5 10]);
xlim([0 duration3]);

subplot (3,3,6) %spectrum
stem(f3,P1_3) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,9) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% comparison between materials - Mouth SEMI Open

signal_1= Me_Nitrile_mouthSEMIopen(:,2);
t1=linspace(0,(length(signal_1)-120)*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

[pks,index] = findpeaks(pbf_signal_1(400:end-360),t1(400:end-360),'MinPeakDistance',0.07);
mean_peak_1 = mean(pks);

signal_2 = Me_Exp_SEMIopen(:,2);
t2=linspace(0,(length(signal_2)-120)*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);
[pks,index] = findpeaks(pbf_signal_2(400:end-360),t2(400:end-360),'MinPeakDistance',0.07);
mean_peak_2 = mean(pks);

signal_3 = Me_Tape_SEMIopen(:,2);
t3=linspace(0,(length(signal_3)-120)*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);
[pks,index] = findpeaks(pbf_signal_3(400:end-360),t3(400:end-360),'MinPeakDistance',0.07);
mean_peak_3 = mean(pks);

%% signal 1
figure
sgtitle('Comparison between materials - Mouth SEMI Open')
subplot (3,3,1) %signal
plot(t1, signal_1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Nitrile")
ylim ([-5 10]);
xlim([0 duration1]);

subplot (3,3,4) %spectrum
stem(f1,P1_1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,7) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([ylimmin ylimmax]);
hold on
yline(mean_peak_1, '--r');

%% signal 2

subplot (3,3,2) %signal
plot(t2, signal_2)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Exposed")
ylim ([-5 10]);
xlim([0 duration2]);

subplot (3,3,5) %spectrum
stem(f2,P1_2) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,8) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([ylimmin ylimmax]);
hold on
yline(mean_peak_2, '--r');

%% signal 3

subplot (3,3,3) %signal
plot(t3, signal_3)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - Tape")
ylim ([-5 10]);
xlim([0 duration3]);

subplot (3,3,6) %spectrum
stem(f3,P1_3) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,9) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([ylimmin ylimmax]);
hold on
yline(mean_peak_3, '--r');

%% comparison between subjects - Nose Respiration

signal_1= Me_Tape_Nose(:,2);
t1=linspace(0,(length(signal_1)-120)*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

signal_2 = Ver_tape_Nose(:,2);
t2=linspace(0,(length(signal_2)-120)*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

signal_3 = Alli_tape_Nose(:,2);
t3=linspace(0,(length(signal_3)-120)*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

%% signal 1
figure
sgtitle('Comparison between subjects - Nose Respiration')
subplot (3,3,1) %signal
plot(t1, signal_1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - tape")
ylim ([-5 10]);
xlim([0 duration1]);

subplot (3,3,4) %spectrum
stem(f1,P1_1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,7) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

%% signal 2

subplot (3,3,2) %signal
plot(t2, signal_2)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject2 - tape")
ylim ([-5 10]);
xlim([0 duration2]);

subplot (3,3,5) %spectrum
stem(f2,P1_2) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,8) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

%% signal 3

subplot (3,3,3) %signal
plot(t3, signal_3)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject3 - tape")
ylim ([-5 10]);
xlim([0 duration3]);

subplot (3,3,6) %spectrum
stem(f3,P1_3) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,9) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");


%% comparison between subjects - Open Mouth Respiration

signal_1= Me_Tape_COMPLopen(:,2);
t1=linspace(0,(length(signal_1)-120)*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

signal_2 = Ver_tape_COMPLopen(:,2);
t2=linspace(0,(length(signal_2)-120)*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

signal_3 = Alli_tape_COMPLopen(:,2);
t3=linspace(0,(length(signal_3)-120)*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

%% signal 1
figure
sgtitle('Comparison between subjects - Open Mouth Respiration')
subplot (3,3,1) %signal
plot(t1, signal_1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - tape")
ylim ([-5 10]);
xlim([0 duration1]);

subplot (3,3,4) %spectrum
stem(f1,P1_1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,7) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

%% signal 2

subplot (3,3,2) %signal
plot(t2, signal_2)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject2 - tape")
ylim ([-5 10]);
xlim([0 duration2]);

subplot (3,3,5) %spectrum
stem(f2,P1_2) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,8) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

%% signal 3

subplot (3,3,3) %signal
plot(t3, signal_3)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject3 - tape")
ylim ([-5 10]);
xlim([0 duration3]);

subplot (3,3,6) %spectrum
stem(f3,P1_3) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,9) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

%% comparison between subjects - SEMI open Mouth Respiration

signal_1= Me_Tape_SEMIopen(:,2);
t1=linspace(0,(length(signal_1)-120)*(1/12)/60,(length(signal_1)));
duration1 = length(signal_1)*(1/12)/60 + 0.05;
[P1_1,f1] = freq_analysis(signal_1);
pbf_signal_1 = bandpass(signal_1,fpass,Fs);

signal_2 = Ver_tape_SEMIopen(:,2);
t2=linspace(0,(length(signal_2)-120)*(1/12)/60,(length(signal_2)));
duration2 = length(signal_2)*(1/12)/60 + 0.05;
[P1_2,f2] = freq_analysis(signal_2);
pbf_signal_2 = bandpass(signal_2,fpass,Fs);

signal_3 = Alli_tape_SEMIopen(:,2);
t3=linspace(0,(length(signal_3)-120)*(1/12)/60,(length(signal_3)));
duration3 = length(signal_3)*(1/12)/60 + 0.05;
[P1_3,f3] = freq_analysis(signal_3);
pbf_signal_3 = bandpass(signal_3,fpass,Fs);

%% signal 1
figure
sgtitle('Comparison between subjects - Semi Mouth Respiration')
subplot (3,3,1) %signal
plot(t1, signal_1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject1 - tape")
ylim ([-5 10]);
xlim([0 duration1]);

subplot (3,3,4) %spectrum
stem(f1,P1_1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,7) %signal filtered
plot(t1,pbf_signal_1, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");


%% signal 2

subplot (3,3,2) %signal
plot(t2, signal_2)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject2 - tape")
ylim ([-5 10]);
xlim([0 duration2]);

subplot (3,3,5) %spectrum
stem(f2,P1_2) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,8) %signal filtered
plot(t2,pbf_signal_2, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");

%% signal 3

subplot (3,3,3) %signal
plot(t3, signal_3)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Subject3 - tape")
ylim ([-5 10]);
xlim([0 duration3]);

subplot (3,3,6) %spectrum
stem(f3,P1_3) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim(f_lim);

subplot (3,3,9) %signal filtered
plot(t3,pbf_signal_3, 'b');
title("Filtered Signal - passband");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
