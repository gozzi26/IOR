clear all
close all
%% import
calInMouthexposed = importfile_exposed("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_02_15-10_calInMouth_exposed.xlsx", "2021_02_15-10_calInMouth_expose", [1, 3013]);
[num,txt,raw] = xlsread('2021_02_17-01_calInMouth_covered');
A=xlsread("2021_02_17-01_calInMouth_covered");

%% assign variables
data_elliptical_nodeg = calInMouthexposed;
data_elliptical = data_elliptical_nodeg;

%% Calibration

t=linspace(0,10,120); %10 seconds for calibration
pcal1=data_elliptical(1:120,2);
tcal1=data_elliptical(1:120,1);
pavg1=mean(pcal1);
tavg1=mean(tcal1);

figure()
subplot(2,1,1)
plot(t', pcal1)
xlabel("time [s]")
ylabel("atmospheric pressure [cmH2O]");
hold on 
yl=yline(pavg1, '--r','P-avg');
yl.LabelHorizontalAlignment = 'left';
title("Calibration")
subplot(2,1,2)
plot(t',tcal1)
yl=yline(tavg1, '--r','T-avg');
yl.LabelHorizontalAlignment = 'left';
xlabel("time [s]")
ylabel("Temperature [C]");

%% Raw signal, with swallowing

t1=linspace(0,(length(data_elliptical)-120)*(1/12)/60,(length(data_elliptical)-120)); %5 minutes of acquisition
pred1=data_elliptical(121:end,2);
tred1=data_elliptical(121:end,1);

figure()
subplot(2,1,1)
plot(t1', pred1)
% hold on
% xline(9.537, '--r', 'Swallow')
% hold on
% xline(9.894, '--r', 'Swallow')
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, with swallowing")
ylim ([-3 +7]);
xlim([0 4]);
subplot(2,1,2)
plot(t1',tred1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 4]);
ylim ([25 45]);

%% Raw signal, without swallowing

% remove from pressure
in=find(abs(data_elliptical_nodeg(121:end,2))>8);
for i=1:length(in)
    in(i)=in(i)+120; 
end 
 
in(end+1)=2;   % adds new endpoint to very end of A so code picks up end of last group of consecutive values
I_1=find(diff(in)~=1);  % finds where sequences of consecutive numbers end
 
data_elliptical_nodeg((in(1):in(I_1(1))),2) =(data_elliptical_nodeg(in(1)-1,2) + data_elliptical_nodeg(in(I_1(1))+1,2))/2;
 
for j=2:length(I_1)
    data_elliptical_nodeg(in(I_1(j-1)+1):in(I_1(j)),2) = (data_elliptical_nodeg(in(I_1(j-1)+1)-1,2) + data_elliptical_nodeg(in(I_1(j))+1,2))/2;
end 
 
% remove from temperature
in1=find(data_elliptical_nodeg(121:end,1)<0);
for i=1:length(in1)
   
    in1(i)=in1(i)+120; 
end 

in1(end+1)=2;   % adds new endpoint to very end of A so code picks up end of last group of consecutive values
I_2=find(diff(in1)~=1);  % finds where sequences of consecutive numbers end

data_elliptical_nodeg((in1(1):in1(I_2(1))),1) =(data_elliptical_nodeg(in1(1)-1,1) + data_elliptical_nodeg(in1(I_2(1))+1,1))/2;

for j=2:length(I_2)
data_elliptical_nodeg(in1(I_2(j-1)+1):in1(I_2(j)),1) = (data_elliptical_nodeg(in1(I_2(j-1)+1)-1,1) + data_elliptical_nodeg(in1(I_2(j))+1,1))/2;
end 
 


t1nd=linspace(0,10.6,(length(data_elliptical_nodeg)-120)); %5 minutes of acquisition



pcal1nd=data_elliptical_nodeg(1:120,2);
tcal1md=data_elliptical_nodeg(1:120,1);
tavg1nd=mean(tcal1);
pred1nd_nf=data_elliptical_nodeg(121:end,2);
tred1nd=data_elliptical_nodeg(121:end,1);
% load("pressure7Wdeglab.mat");
% load("pressure7Wnodeglab.mat");

figure()
subplot(2,1,1)
plot(t1nd', pred1nd_nf,'b')
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, without swallowing")
subplot(2,1,2)
plot(t1nd',tred1nd)
xlabel("time [min]")
ylabel("Temperature [C]");
