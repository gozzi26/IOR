clear all
close all
Meoral2 = importfile0302_oral2("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_02-Me_oral_2.xlsx", "2021_03_02-Me_oral_2", [1, 2415]);
%% assign variables
data_elliptical_nodeg = Meoral2;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%processing
Fs = 12;              % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(p_red1);   % Length of signal
t = (0:L-1)*T;        % Time vector
X = p_red1;           % Singal


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
figure()
subplot(2,1,1)
plot(t1', p_red1)
hold on
% yline(3.5, '--r');
% yline(6.5, '--r');
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, with swallowing")
ylim ([-5 9]);
xlim([0 duration]);
subplot(2,1,2)
plot(t1',t_red1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 duration]);
ylim ([25 45]);


%% PROCESSING

%% freq analysis

Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

% P = abs(fft(X));
% 
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*((L/2)-1)/L;
% figure
% plot(f,P(2:(L/2)+1)) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

figure
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%xlim([0 2]);

%% PassBand Filter

% [freq_pks,index_freq]=findpeaks(P1,f,'MinPeakDistance',0.2,'MinPeakHeight',.1);
% for i= 
% end
fpass = [0.1 0.4];
data_passbandfilter = bandpass(X,fpass,Fs);

figure()
%subplot(2,1,1)
plot(t1,p_red1, 'r')
hold on 
plot(t1,data_passbandfilter, 'b');
legend("signal", "filtered signal");
title("SIGNAL AND FILTERED SIGNAL");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([-6 +9]);
xlim([0 duration]);

% subplot(2,1,2)
% plot(t1,p_red1, 'r')
% hold on 
% plot(t1,data_passbandfilter, 'b');
% legend("signal", "filtered signal");
% title("Enlargement of the signal");
% xlabel("time [min]")
% ylabel("Pressure [cmH2O]");
% ylim ([-6 +9]);
% xlim([5 6]);

%% remove from pressure

data_noswallowing = data_passbandfilter;
index_high_p_values = find(data_noswallowing>3);

if not(isempty(index_high_p_values))
    for i=index_high_p_values
        data_noswallowing(index_high_p_values) = data_noswallowing(index_high_p_values(1));
    end
end

index_low_p_values = find(data_noswallowing<-3);
if not(isempty(index_low_p_values))
    for i=index_high_p_values
        data_noswallowing(index_low_p_values) = data_noswallowing(index_low_p_values(1));
    end
end

figure()
subplot(2,1,1)
plot(t1,data_noswallowing, 'r')
title("Signal no swallowing");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
ylim ([-6 +6]);
xlim([0 duration]);

%% count the breath
data_RR=data_noswallowing;
time_RR_sec=t1.*60;

figure
findpeaks(data_RR,time_RR_sec,'MinPeakDistance',0.03*60);
[pks,index] = findpeaks(data_RR,time_RR_sec,'MinPeakDistance',0.03*60);

period_RR = diff(index);
freq_RR = 1./period_RR; %1/sec
% figure
% plot(index(1:end-1),freq_RR);
% ylim ([5 25]);

freq_RR_b_permin = 1./period_RR.*60; %1/min
freq_RR_permin_avg = movmean(freq_RR_b_permin,8);
figure
plot(index(1:end-1),freq_RR_permin_avg);
title("Respiratory Rate - moving average with sliding window of length 8");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);