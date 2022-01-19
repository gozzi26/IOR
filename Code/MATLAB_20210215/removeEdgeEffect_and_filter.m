function [outputArg1] = removeEdgeEffect_and_filter (signal,fpass,Fs)

%%%%% remove the edge effect
%Prefixing AND Appending the original signal with a small number (10-100) 
%of the beginning AND ending sections of the signal, respectively. 
%The sections are flipped and shifted in order to maintain continuity 
%in signal level and slope at the joining points. After filtering, 
%the prefixed AND the appended portions of the filtered signal are removed.



x=signal;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R=0.1; % 10% of signal
Nr=75;
N=size(x,1);
NR=min(round(N*R),Nr); % At most 75 points
% attach a flipped vector at the beginning of the signal
x1(:,1)=2*x(1,1)-flipud(x(2:NR+1,1));  % flipping allows maintain continuity in level and slope
% attach a flipped vector at the end of the signal
x2(:,1)=2*x(end,1)-flipud(x(end-NR:end-1,1));
x=[x1;x;x2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Do filtering
%pbf_signal_1_mod = bandpass(x,fpass,Fs);
pbf_signal_1_mod = lowpass(x,fpass,Fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%remove useless parts
pbf_signal_1_mod=pbf_signal_1_mod(NR+1:end-NR,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputArg1 = pbf_signal_1_mod;
end

