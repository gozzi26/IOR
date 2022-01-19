close all
clear all

Me_NotEncapsulated_closed = readmatrix('2021_03_15-Me_Not encapsulated_Nose.xlsx');
Me_NotEncapsulated_openMouth = readmatrix('2021_03_15-Me_Not encapsulated_OpenMouth.xlsx');
Me_NotEncapsulated_SEMIopenMouth = readmatrix('2021_03_15-Me_Not encapsulated_SEMIOpenMouth.xlsx');

Me_exposed_closed_prova0309 = readmatrix('2021_03_09-Me_Exposed_closed.xlsx');
Me_exposed_openMouth_prova0309 = readmatrix('2021_03_09-Me_Exposed_OpenMouth.xlsx');
Me_exposed_SEMIopenMouth_prova0309 = readmatrix('2021_03_09-Me_Exposed_SEMIOpenMouth.xlsx');

% Me_exposed_closed_prova0304 = readmatrix('2021_03_04-Me2_exposed_Nose.xlsx');
%     Me_exposed_closed_prova0304 = Me_exposed_closed_prova0304(1:3900,:);
% Me_exposed_openMouth_prova0304 = readmatrix('2021_03_04-Me4_exposed_COMPLopen.xlsx');
%     Me_exposed_openMouth_prova0304 = Me_exposed_openMouth_prova0304(1:2000,:);
% Me_exposed_SEMIopenMouth_prova0304 = readmatrix('2021_03_04-Me3_exposed_SEMIopen.xlsx');
%     Me_exposed_SEMIopenMouth_prova0304 = Me_exposed_SEMIopenMouth_prova0304 (1:2100,:);


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

signal_1= Me_NotEncapsulated_closed(:,2);
t1=linspace(0,(length(signal_1))*(1/12)/60,(length(signal_1)));
pbf_signal_1 = removeEdgeEffect_and_filter (signal_1,fpass,Fs);
[P1_1_pbf,f1_pbf] = freq_analysis(pbf_signal_1);  %freq_analysis of the filtered signal
[t_freq_RR_1,freq_RR_permin_MovAvg_1] = RemovePress_CountBreath(pbf_signal_1);

signal_2 = Me_NotEncapsulated_openMouth(:,2);
t2=linspace(0,(length(signal_2))*(1/12)/60,(length(signal_2)));
pbf_signal_2 = removeEdgeEffect_and_filter (signal_2,fpass,Fs);
[P1_2_pbf,f2_pbf] = freq_analysis(pbf_signal_2);  %freq_analysis of the filtered signal
[t_freq_RR_2,freq_RR_permin_MovAvg_2] = RemovePress_CountBreath(pbf_signal_2);

signal_3 = Me_NotEncapsulated_SEMIopenMouth(:,2);
t3=linspace(0,(length(signal_3))*(1/12)/60,(length(signal_3)));
pbf_signal_3 = removeEdgeEffect_and_filter (signal_3,fpass,Fs);
[P1_3_pbf,f3_pbf] = freq_analysis(pbf_signal_3);  %freq_analysis of the filtered signal
[t_freq_RR_3,freq_RR_permin_MovAvg_3] = RemovePress_CountBreath(pbf_signal_3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% signal 1
figure
sgtitle('The new board RESULTS - Not Encapsulated')

subplot (3,3,1) %signal filtered
plot(t1,signal_1, 'b');
title("Nose Respiration");
xlabel("time [min]");
ylabel("Pressure [cmH2O]");

subplot (3,3,4) %signal filtered spectrum
plot(t1,pbf_signal_1) 
title('Filtered Signal - PassBand Filter [0.1 - 0.4]Hz')
xlabel("time [min]");
ylabel("Pressure [cmH2O]");


subplot (3,3,7) %signal filtered spectrum
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


%% Comparison between old signals and new signals
signal_1_old=Me_exposed_closed_prova0309(:,2);
t1_old=linspace(0,(length(signal_1_old))*(1/12)/60,(length(signal_1_old)));

signal_2_old= Me_exposed_openMouth_prova0309(:,2);
t2_old=linspace(0,(length(signal_2_old))*(1/12)/60,(length(signal_2_old)));

signal_3_old= Me_exposed_SEMIopenMouth_prova0309(:,2);
t3_old=linspace(0,(length(signal_3_old))*(1/12)/60,(length(signal_3_old)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
sgtitle('Comparison between the NEW and the OLD board')

subplot(2,3,1)
plot(t1,signal_1);
title("Nose Respiration NEW");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
p=polyfit(t1',signal_1,2);
y = polyval(p,t1);
hold on
plot(t1,y,'r')

subplot (2,3,4) 
plot(t1_old,signal_1_old);
title("Nose Respiration OLD");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
p=polyfit(t1_old',signal_1_old,2);
y = polyval(p,t1_old);
hold on
plot(t1_old,y,'r')

%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,3,2)
plot(t2,signal_2);
title("Open Mouth Respiration NEW");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
p=polyfit(t2',signal_2,2);
y = polyval(p,t2);
hold on
plot(t2,y,'r')

subplot (2,3,5) 
plot(t2_old,signal_2_old);
title("Open Mouth Respiration OLD");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
p=polyfit(t2_old',signal_2_old,2);
y = polyval(p,t2_old);
hold on
plot(t2_old,y,'r')

%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,3,3)
plot(t3,signal_3 );
title("Semi Open Mouth Respiration NEW");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
p=polyfit(t3',signal_3,2);
y = polyval(p,t3);
hold on
plot(t3,y,'r')

subplot (2,3,6) 
plot(t3_old,signal_3_old);
title("Semi Open Mouth Respiration OLD");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
p=polyfit(t3_old',signal_3_old,2);
y = polyval(p,t3_old);
hold on
plot(t3_old,y,'r')
