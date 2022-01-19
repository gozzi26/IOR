clear all
close all

Me4mouthSEMIopen = importfile0302_me4_semiOpen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_02-Me4_mouthSEMIopen.xlsx", "2021_03_02-Me4_mouthSEMIopen", [89, 2243]);

%% assign variables
data_elliptical_nodeg = Me4mouthSEMIopen;
data_elliptical = data_elliptical_nodeg;

%% define variables

%Raw signal
t1=linspace(0,(length(data_elliptical)-120)*(1/12)/60,(length(data_elliptical))); 
p_red1=data_elliptical(:,2);
t_red1=data_elliptical(:,1);
duration = length(p_red1)*(1/12)/60 + 0.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%processing
Fs = 12;              % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = length(p_red1);   % Length of signal
t = (0:L-1)*T;        % Time vector
X = p_red1;           % Singal

%% Raw signal, with swallowing
figure()
subplot(2,1,1)
plot(t1', p_red1)
hold on
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, with swallowing")
%ylim ([-5 9]);
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

figure
stem(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0 1]);

%% PassBand Filter

fpass = [0.1 0.25];
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
findpeaks(data_RR,time_RR_sec,'MinPeakDistance',0.04*60);
[pks,index] = findpeaks(data_RR,time_RR_sec,'MinPeakDistance',0.04*60);

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



%% final plot
figure
subplot (3,1,1) %signal
plot(t1', p_red1)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal - Semi Open mouth Respiration")
ylim ([-5 9]);
xlim([0 duration]);

subplot (3,1,2) %spectrum
stem(f,P1) 
title('Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')
ylabel('|P1(f)|')
xlim([0 1]);

subplot (3,1,3) %signal filtered
plot(t1,data_passbandfilter, 'b');
title("Filtered Signal - passband [0.1 0.25] Hz");
xlabel("time [min]")
ylabel("Pressure [cmH2O]");