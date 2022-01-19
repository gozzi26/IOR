function [outputArg1,outputArg2] = freq_analysis(signal)

Fs = 12;              % Sampling frequency                    
N = length(signal);
f=(1:N-1)*Fs/N;
%t=(1:N)*Fs;

X = abs(fft(signal));
Nhalf = N/2;


outputArg2 = f(1:Nhalf-1);  %x axis
outputArg1 = X(2:Nhalf); %y axis

end

