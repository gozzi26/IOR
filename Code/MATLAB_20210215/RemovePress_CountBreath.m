function [outputArg1,outputArg2] = RemovePress_CountBreath(signal)

t1=linspace(0,(length(signal))*(1/12)/60,length(signal)); 


%% remove from pressure
data_noswallowing = signal;
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

%% count the breath
min_peak_dist=2; %sec
min_peak_prom = 0.8; %cmH2O

data_RR=data_noswallowing;
time_RR_sec=t1.*60;

figure
findpeaks(data_RR,time_RR_sec,'MinPeakDistance',min_peak_dist,'MinPeakProminence',min_peak_prom);
title("Respiratory rate Computation");
xlabel("time [sec]")
ylabel("Pressure [cmH2O]");

[pks,index] = findpeaks(data_RR,time_RR_sec,'MinPeakDistance',min_peak_dist, 'MinPeakProminence',min_peak_prom);
period_RR = diff(index);
freq_RR = 1./period_RR; % [Hz=1/s]
freq_RR_b_permin = freq_RR*60; % [1/min]
freq_RR_permin_MovAvg = movmean(freq_RR_b_permin,8); % moving average


figure
plot(index(1:end-1),freq_RR_permin_MovAvg);
title("Respiratory Rate - moving average with sliding window of length 8");
xlabel("time [sec]")
ylabel("Breaths per minute");
ylim ([5 25]);

outputArg1 = index(1:end-1);
outputArg2 = freq_RR_permin_MovAvg;

end

