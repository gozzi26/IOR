close all
clear all
Subject1_Nose_changetime_22 = readmatrix('2021_03_17_Nose_change_time_2&2.xlsx');
Subject1_Nose_changetime_22_2 = readmatrix('2021_03_18_Nose_change_time_2&2.xlsx');
Subject1_Nose_changetime_24 = readmatrix('2021_03_17_Nose_change_time_2&4.xlsx');

Subject1_Nose_changetime_23_1 = readmatrix('2021_03_17_Nose_change_time_2&3_just 2.xlsx');
Subject1_Nose_changetime_23_2 = readmatrix('2021_03_17_Nose_change_time_2&3_just 2_second.xlsx');
Subject1_Nose_changetime_23_3 = readmatrix('2021_03_17_Nose_change_time_2&3_third.xlsx');
%% Generic data for the signals
Fs = 12; %Sample freq

% %passband filter
% f_min=0.1;
% f_max=0.4;
% fpass = [f_min f_max];

%lowpass
fpass = 0.4;

%graphs
f_lim=[0 1]; %xlim vector for the graphs
ylimmin = -2;
ylimmax = 2;

lenght_sig = 90;
bef_begin = 20;


%% 2 In + 2 Exp
signal_1= Subject1_Nose_changetime_22_2(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = lowpass(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

figure
sgtitle('Nose respiration - Forced insp and expiration at different speed')
plot(pbf_signal_1, 'b');
title('Raw Signal - Subject 1 - 22');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");


signal_1 = pbf_signal_1;

% begin1 = 976;
% begin2 = 1367;
% begin3 = 1849;
% begin4 = 2420;
% begin5 = 2881;

begin1 = 194;
begin2 = 553;
begin3 = 1017;
begin4 = 1454;
begin5 = 1900;
FirstPEAK = signal_1(begin1-bef_begin:begin1+lenght_sig);
SecondPEAK = signal_1(begin2-bef_begin:begin2+lenght_sig);
ThirdPEAK =  signal_1(begin3-bef_begin:begin3+lenght_sig);
FourthPEAK =  signal_1(begin4-bef_begin:begin4+lenght_sig);
FifthPEAK =  signal_1(begin5-bef_begin:begin5+lenght_sig);

t_peak=linspace(0,(length(FirstPEAK))*(1/12),(length(FirstPEAK)));

figure
sgtitle('Data validation: Forced insp and expiration at different speed')
plot (FirstPEAK, 'b') 
hold on
plot (SecondPEAK, 'r') 
hold on
plot (ThirdPEAK, 'y') 
hold on
plot (FourthPEAK, 'k') 
hold on
plot (FifthPEAK, 'g')

peak22 = [FirstPEAK SecondPEAK ThirdPEAK FourthPEAK FifthPEAK];
peak22_avg = mean(peak22,2);

figure
sgtitle('22')
plot (peak22_avg, 'r')


%% 2&4
signal_1= Subject1_Nose_changetime_24(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = lowpass(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

figure
sgtitle('Nose respiration - Forced insp and expiration at different speed')
plot(signal_1, 'b');
title('Raw Signal - Subject 1 - 24');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

signal_1 = pbf_signal_1;

begin1 = 214;
begin2 = 527;
begin3 = 902;
begin4 = 1327;
begin5 = 1717;

FirstPEAK = signal_1(begin1-bef_begin:begin1+lenght_sig);
SecondPEAK = signal_1(begin2-bef_begin:begin2+lenght_sig);
ThirdPEAK =  signal_1(begin3-bef_begin:begin3+lenght_sig);
FourthPEAK =  signal_1(begin4-bef_begin:begin4+lenght_sig);
FifthPEAK =  signal_1(begin5-bef_begin:begin5+lenght_sig);

t_peak=linspace(0,(length(FirstPEAK))*(1/12),(length(FirstPEAK)));

figure
sgtitle('Data validation: Forced insp and expiration at different speed')
plot (FirstPEAK, 'b') 
hold on
plot (SecondPEAK, 'r') 
hold on
plot (ThirdPEAK, 'y') 
hold on
plot (FourthPEAK, 'k') 
hold on
plot (FifthPEAK, 'g')

peak24 = [FirstPEAK SecondPEAK ThirdPEAK FourthPEAK FifthPEAK];
peak24_avg = mean(peak24,2);

figure
sgtitle('24')
plot (peak24_avg, 'b')


%% 2&3

signal_1= Subject1_Nose_changetime_23_1(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = lowpass(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

figure
sgtitle('Nose respiration - Forced insp and expiration at different speed')
plot(signal_1, 'b');
title('Raw Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");


signal_1 = pbf_signal_1;

begin1 = 536;
begin2 = 1122;

FirstPEAK = signal_1(begin1-bef_begin:begin1+lenght_sig);
SecondPEAK = signal_1(begin2-bef_begin:begin2+lenght_sig);

t_peak=linspace(0,(length(FirstPEAK))*(1/12),(length(FirstPEAK)));


%second signal for 2&3
signal_1= Subject1_Nose_changetime_23_2(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = lowpass(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);
figure
sgtitle('Nose respiration - Forced insp and expiration at different speed')
plot(signal_1, 'b');
title('Raw Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");


signal_1 = pbf_signal_1;

begin3 = 478;
begin4 = 934;
ThirdPEAK =  signal_1(begin3-bef_begin:begin3+lenght_sig);
FourthPEAK =  signal_1(begin4-bef_begin:begin4+lenght_sig);


%third signal for 2&3
signal_1= Subject1_Nose_changetime_23_3(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = lowpass(signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);
figure
sgtitle('Nose respiration - Forced insp and expiration at different speed')
plot(signal_1, 'b');
title('Raw Signal - Subject 1 - Nose');
xlabel("time [min]");
ylabel("Pressure [cmH2O]");


signal_1 = pbf_signal_1;


begin5 = 258;
FifthPEAK =  signal_1(begin5-bef_begin:begin5+lenght_sig);

figure
sgtitle('Data validation: Forced insp and expiration at different speed')
plot (FirstPEAK, 'b') 
hold on
plot (SecondPEAK, 'r')
hold on
plot (ThirdPEAK, 'y') 
hold on
plot (FourthPEAK, 'k') 
hold on
plot (FifthPEAK, 'g')

peak23 = [FirstPEAK SecondPEAK ThirdPEAK FourthPEAK FifthPEAK]; 
peak23_avg = mean(peak23,2);

figure
sgtitle('23')
plot (peak23_avg, 'k')

figure
sgtitle('Data Validation - EXHALATION time variation')
p=plot (t_peak(1:76),peak22_avg(1:76), 'r', t_peak(1:89),peak23_avg(1:89), 'k', t_peak(1:103),peak24_avg(1:103), 'b');
p(1).LineWidth = 2;
p(2).LineWidth = 2;
p(3).LineWidth = 2;
hold on
% p2=plot (t_peak(1:89),peak23_avg(1:89), 'k');
% hold on
% p3 = plot (t_peak(1:103),peak24_avg(1:103), 'b');
yline(0, '--r');
%hold on
%xline(1.9, '--g', 'start INH: 1.9 sec');

%x1=xline(4, '--r', '4 sec');
%xline(6.2885, '--r', 'end EXH: 6.23 sec');

%xline(3.995, '--k', '4 sec');
%xline(7.36025, '--k', 'end EXH: 7.36 sec');

%xline(4.2, '--b', '4.2 sec');
%xline(8.5773, '--b', 'end EXH: 8.5 sec');

legend("2sec IN + 2sec EXH", "2sec IN + 3sec EXH", "2sec IN + 4sec EXH");
xlabel("time [sec]")
ylabel("Pressure [cmH2O]");

