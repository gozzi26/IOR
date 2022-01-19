clear all
close all
data_elliptical_nodeg = xlsread("lab7.xlsx");
data_elliptical = data_elliptical_nodeg;

% remove from pressure
in=find(abs(data_elliptical_nodeg(121:end,2))>3);
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

t=linspace(0,10,120); %10 seconds for calibration
t1=linspace(0,10.6,(length(data_elliptical)-120)); %5 minutes of acquisition
t1nd=linspace(0,10.6,(length(data_elliptical_nodeg)-120)); %5 minutes of acquisition
pcal1=data_elliptical(1:120,2);
tcal1=data_elliptical(1:120,1);
tavg1=mean(tcal1);
pavg1=mean(pcal1);
pred1=data_elliptical(121:end,2);
tred1=data_elliptical(121:end,1);
pcal1nd=data_elliptical_nodeg(1:120,2);
tcal1md=data_elliptical_nodeg(1:120,1);
tavg1nd=mean(tcal1);
pred1nd_nf=data_elliptical_nodeg(121:end,2);
tred1nd=data_elliptical_nodeg(121:end,1);
% load("pressure7Wdeglab.mat");
% load("pressure7Wnodeglab.mat");
%%
figure()
subplot(2,1,1)
plot(t', pcal1)
xlabel("time [s]")
ylabel("atmospheric pressure [cmH2O]");
hold on 
yl=yline(pavg1, '--r','997.83');
yl.LabelHorizontalAlignment = 'left';
title("Calibration")
subplot(2,1,2)
plot(t',tcal1)
yl=yline(tavg1, '--r','27.585');
yl.LabelHorizontalAlignment = 'left';
xlabel("time [s]")
ylabel("Temperature [C]");
%%
figure()
 
subplot(2,1,1)
 
plot(t1', pred1)
hold on
xline(9.537, '--r', 'Swallow')
hold on
xline(9.894, '--r', 'Swallow')
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Raw signal, with swallowing")
xlim([0 11]);
subplot(2,1,2)
plot(t1',tred1)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 11]);
%%
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
 %%
fc = 2;
fs = 12;
[b,a] = butter(5,fc/(fs/2));
 
pred1nd=filtfilt(b,a,pred1nd_nf);
figure()
plot(pred1nd_nf, 'b')
hold on 
plot(pred1nd, '--r');
legend("signal", "filtered signal");
title("SIGNAL AND FILTERED SIGNAL")

%%
 
figure()
subplot(2,1,1)
plot(t1nd', pred1nd);
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Denoised signal, no swallowing");
xlim([0 11]);
subplot(2,1,2)
plot(t1nd',tred1nd)
xlabel("time [min]")
ylabel("Temperature [C]");
xlim([0 11]);
 
 
%% EXERCISE
G7=load('GiuliaOEP_7.dat');
% load("dG7");
% figure()
% yyaxis left
% plot((linspace(100,634.5,6414))', pressure7Wnodeglab(1220:end)); %%evaluate whether to seprate SVC
% title("Intra-Oral Respirometer vs OEP");
% xlabel("time [min]")
% ylabel("atmospheric pressure [cmH2O]");
% hold on
% yyaxis right
% plot(G7(10001:end,1),[zeros(6,1);dG7(10001:end)], '--r');
% ylabel("Flow [L/s]");
% xlim([100 635]);
figure()
plot(G7(:,1),(gradient(G7(:,5))/0.01),'--r');
hold on 
plot(G7(:,1), G7(:,5)-mean(G7(:,5)), 'b');
title('DERIVATIVE WITH DIFF VS OEP SIGNAL');
legend('derivative of volume', 'Volume');
xlim([0 309]);
% filter derivative
fc=5;
fs = 100;
[b,a] = butter(5,fc/(fs/2));
g=(gradient(G7(:,5))/0.01);
y=filtfilt(b,a,(gradient(G7(:,5))/0.01));
figure()
plot((gradient(G7(:,5))/0.01), 'b')
hold on 
plot(y, '--r');
legend("derivative", "filtered derivative");
title("DERIVATIVE AND FILTERED DERIVATIVE")
 
 
%% DERIVATIVE 1

figure()
plot(G7((10001:21001 ),1),(gradient(G7((10001:21001 ),5))/0.01),'--r');
hold on 
plot(G7((10001:21001 ),1), G7((10001:21001 ),5)-mean(G7((10001:21001 ),5)), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('DERIVATIVE 1 WITH DIFF VS OEP SIGNAL');
legend('derivative of volume', 'Volume');

% filter derivative
fc = 1;
fs = 100;
[b,a] = butter(5,fc/(fs/2));
g=(gradient(G7((10001:21001 ),5))/0.01);
y1=filtfilt(b,a,(gradient(G7((10001:21001 ),5))/0.01));
figure()
plot((gradient(G7((10001:21001 ),5))/0.01), 'b')
hold on 
plot(y1, '--r');
legend("derivative", "filtered derivative");
title("DERIVATIVE AND FILTERED DERIVATIVE")
%% DERIVATIVE 2

figure()
plot(G7( (21001:51301 ),1),(gradient(G7( (21001:51301 ),5))/0.01),'--r');
hold on 
plot(G7( (21001:51301 ),1), G7( (21001:51301),5)-mean(G7( (21001:51301 ),5)), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('DERIVATIVE 2 WITH DIFF VS OEP SIGNAL');
legend('derivative of volume', 'Volume');

% filter derivative
fc = 5;
fs = 100;
[b,a] = butter(5,fc/(fs/2));
g=(gradient(G7( (21001:51301 ),5))/0.01);
y2=filtfilt(b,a,(gradient(G7((21001:51301 ),5))/0.01));
figure()
plot((gradient(G7( (21001:51301 ),5))/0.01), 'b')
hold on 
plot(y2, '--r');
legend("derivative", "filtered derivative");
title("DERIVATIVE AND FILTERED DERIVATIVE")

%% DERIVATIVE 3

figure()
plot(G7( (51301:end),1),(gradient(G7( (51301:end),5))/0.01),'--r');
hold on 
plot(G7(  (51301:end),1), G7(  (51301:end),5)-mean(G7( (51301:end),5)), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('DERIVATIVE 3 WITH DIFF VS OEP SIGNAL');
legend('derivative of volume', 'Volume');

% filter derivative
fc = 1;
fs = 100;
[b,a] = butter(5,fc/(fs/2));
g=(gradient(G7( (51301:end),5))/0.01);
y3=filtfilt(b,a,(gradient(G7((51301:end),5))/0.01));
figure()
plot((gradient(G7( (51301:end),5))/0.01), 'b')
hold on 
plot(y3, '--r');
legend("derivative", "filtered derivative");
title("DERIVATIVE AND FILTERED DERIVATIVE")
%%
% figure()
% plot(G7( (25001:30001),1),y3, 'r');
% hold on
% plot((linspace(251,301.5,601)),pred1nd(3000:3600), 'b');
%% CFR DERIVATIVE (FLUSSO) WITH PRESSURE
figure()
yyaxis left
plot((linspace(100,636,6434))', [pred1nd(1200:end)],'b');
title("Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(10001:end,1),y(10001:end),'--r');
ylabel("Flow [L/s]");

figure()
yyaxis left
plot((linspace(100,636,6434))', [-pred1nd(1200:end)],'b');
title("2Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(10001:end,1),y(10001:end),'--r');
ylabel("Flow [L/s]");
xlim([100 650])
%% der 1
figure()
yyaxis left
plot((linspace(100,210,1321))', [pred1nd(1200:2520)],'b');
title("Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(10001:21001 ,1),y1,'--r');
ylabel("Flow [L/s]");
 %% der 2
figure()
yyaxis left
plot(( linspace(210,513,3637))', [pred1nd(2520:6156)],'b');
title("Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(21001:51301 ,1),y2,'--r');
ylabel("Flow [L/s]");
 %% der3
figure()
yyaxis left
plot( (linspace(513,636.16, 1478))', [pred1nd(6156:end)],'b');
title("Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(51301:end,1),y3,'--r');
ylabel("Flow [L/s]");
 
%% find peaks in der 1
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[pk1,loc1]=findpeaks(y1, G7(10001:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', 0.3);
RR_OEP1_1=(length(pk1)-1)/1.84;
findpeaks(y1, G7(10001:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', 0.3);
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk2,loc2]=findpeaks(-pred1nd(1200:2520),(linspace(100,210,1321)), 'MinPeakDistance', 2,'MinPeakHeight', 0.1);
findpeaks(-pred1nd(1200:2520),(linspace(100,210,1321)),'MinPeakDistance', 2, 'MinPeakHeight', 0.1);
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MAXIMA IN IOR");
RR_IOR1_1=(length(pk2))/1.84;
maxDER1=[pk1(1:end), pk2(1:end)];
locmaxDER1=[loc1(1:end),loc2(1:end)'];
%% find peaks in der 2
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[pk1,loc1]=findpeaks([y2], G7(21001:51301,1), 'MinPeakDistance', 0.87, 'MinPeakHeight', 1);
RR_OEP1_2=(length(pk1))/5.05;
findpeaks([y2], G7(21001:51301,1), 'MinPeakDistance', 0.87, 'MinPeakHeight', 1);
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk2,loc2]=findpeaks(-pred1nd(2520:6156),(linspace(210,513,3637)), 'MinPeakDistance', 0.8,'MinPeakHeight', 0.8);
findpeaks(-pred1nd(2520:6156),(linspace(210,513,3637)),'MinPeakDistance', 0.8, 'MinPeakHeight', 0.8);
RR_IOR1_2=(length(pk2)-1)/5.05;
maxDER2=[[pk1(1:2);pk1(4:end)], pk2(1:end)];
locmaxDER2=[[loc1(1:2);loc1(4:end)],loc2(1:end)'];
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MAXIMA IN IOR");
 
%% find peaks in der 3
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[pk1,loc1]=findpeaks(y3, G7(51301:end,1), 'MinPeakDistance', 1.2, 'MinPeakHeight', 0.8);
RR_OEP1_3=(length(pk1)+1)/2.06;
findpeaks([y3], G7(51301:end,1), 'MinPeakDistance', 1.2, 'MinPeakHeight', 0.8);
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk2,loc2]=findpeaks(-pred1nd(6156:end),(linspace(513,636.16,1478)), 'MinPeakDistance', 1.2,'MinPeakHeight', 0.01);
findpeaks(-pred1nd(6156:end),(linspace(513,636.16,1478)),'MinPeakDistance', 1.2, 'MinPeakHeight', 0.01);
RR_IOR1_3=(length(pk2)-2)/2.06;
maxDER3=[[pk1(1:end)], [pk2(1:end-2)] ];
locmaxDER3=[[loc1(1:end)],[loc2(1:end-2)']];
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MAXIMA IN IOR");
%% INTEGRAL VOLUME AND VOLUME

% load("I7_W1_nf_.mat");
% load("I7_W2_nf_.mat");
% load("I7_W3_nf_.mat");
I7_1=(cumsum(pred1nd(1200:2520)))*1/12;
I7_2=(cumsum(pred1nd(2520:6156)))*1/12;
I7_3=(cumsum(pred1nd(6156:end)))*1/12;

%% 1 int
load("I7_11.mat");
I7_z1=I7_1-I7_11;
figure()
plot(I7_z1, '--r');
hold on 
plot (pred1nd(1200:2520), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('INTEGRAL 1 VS PRESSURE SIGNAL');
legend('integral of pressure', 'pressure');
fc = 1;
fs = 12;
[b,a] = butter(5,fc/(fs/2));
 
I7_z1f=filtfilt(b,a,I7_z1);
figure()
plot(I7_z1, 'b')
hold on 
plot(I7_z1f, '--r');
legend("integral", "filtered integral");
title("INTEGRAL AND FILTERED INTEGRAL")


figure()
yyaxis left
plot((linspace(100,210,1321))', [I7_z1f(:)],'b');
title("Intra-Oral Respirometer (Integral of Pressure) vs OEP (Volume)");
xlabel("time [s]")
ylabel("Integral of Pressure");
hold on
yyaxis right
plot(G7(10051:21001,1),(G7(10051:21001,5)),'--r');
ylabel("Volume [L]");
%% 2 int
load("I7_21.mat");
I7_z2=I7_2-I7_21;

figure()
plot(I7_z2, '--r');
hold on 
plot (pred1nd(2520:6156), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('INTEGRAL 2 VS PRESSURE SIGNAL');
legend('integral of pressure', 'pressure');
fc = 5;
fs = 12;
[b,a] = butter(5,fc/(fs/2));
 
I7_z2f=filtfilt(b,a,I7_z2);
figure()
plot(I7_z2, 'b')
hold on 
plot(I7_z2f, '--r');
legend("integral", "filtered integral");
title("INTEGRAL AND FILTERED INTEGRAL")

%
figure()
yyaxis left
plot((linspace(210,513,3637))', [I7_z2f(:)],'b');
title("Intra-Oral Respirometer (Integral of Pressure) vs OEP (Volume)");
xlabel("time [s]")
ylabel("Integral of Pressure");
hold on
yyaxis right
plot(G7(20801:51301,1),(G7(20801:51301,5)),'--r');
ylabel("Volume [L]");
xlim([208 515])
%% 3 int
load("I7_31.mat");
I7_z3=(I7_3-I7_31);
%I7_z3=detrend(I7_3,20)
figure()
plot(I7_z3, '--r');
hold on 
plot (pred1nd(6156:end), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('INTEGRAL 3 VS PRESSURE SIGNAL');
legend('integral of pressure', 'pressure');
 
fc = 1; %0.7 = 0.3747
fs = 12;
[b,a] = butter(5,fc/(fs/2));
 
I7_z3f=(filtfilt(b,a,I7_z3));
figure()
plot(I7_z3, 'b')
hold on 
plot(I7_z3f, '--r');
legend("integral", "filtered integral");
title("INTEGRAL AND FILTERED INTEGRAL")

figure()
yyaxis left
plot((linspace(513,636.17,1478))', [I7_z3f(:)],'b');
title("Intra-Oral Respirometer (Integral of Pressure) vs OEP (Volume)");
xlabel("time [s]")
ylabel("Integral of Pressure");
hold on
yyaxis right
plot(G7(51201:end,1),(G7(51201:end,5)),'--r');
ylabel("Volume [L]");
%%
figure()
yyaxis left

plot((linspace(100,636.17,6436))', [-I7_z1f(:);-I7_z2f(:);-I7_z3f(:)],'b');
title("Intra-Oral Respirometer (Integral of Pressure) vs OEP (Volume)");
xlabel("time [s]")
ylabel("Integral of Pressure");
hold on
yyaxis right
plot(G7(10001:end,1),(G7(10001:end,5)),'--r');
ylabel("Volume [L]");
xlim([100 650])
%% find peaks in int 1
figure()
 
subplot(2,1,1)
[pk3,loc3]=findpeaks(G7(10051:21001,5), G7(10051:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', 19);
RR_OEP2_1=(length(pk3))/1.84;
findpeaks(G7(10051:21001,5), G7(10051:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', 19);
xlabel("time [s]");
ylabel("Volume [L]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk4,loc4]=findpeaks([-I7_z1f(:)],(linspace(100,210,1321)), 'MinPeakHeight', 0.03);
findpeaks([-I7_z1f(:)],(linspace(100,210,1321)), 'MinPeakHeight', 0.03);
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
ylabel("Integral of Pressure");
title("MAXIMA IN IOR");
RR_IOR2_1=(length(pk4))/1.84;
maxINT1=[pk3(:), pk4(:)]
locmaxINT1=[loc3(:),loc4(1,:)'];
%% find peaks in int 2
figure()
 
subplot(2,1,1)
[pk3,loc3]=findpeaks(G7(20801:51301,5), G7(20801:51301,1), 'MinPeakDistance', 0.9, 'MinPeakHeight', 18.8);
RR_OEP2_2=(length(pk3)-1)/5.05;
findpeaks(G7(20801:51301,5), G7(20801:51301,1), 'MinPeakDistance', 0.9, 'MinPeakHeight', 18.8);
xlabel("time [s]");
ylabel("Volume [L]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk4,loc4]=findpeaks([-I7_z2f(:)],(linspace(210,513,3637)), 'MinPeakHeight', 0.03);
findpeaks([-I7_z2f(:)],(linspace(210,513,3637)), 'MinPeakHeight', 0.03);
xlabel("time [s]");
ylabel("Integral of Pressure");
title("MAXIMA IN IOR");
RR_IOR2_2=(length(pk4))/5.05;
maxINT2=[[pk3(2:end)], pk4(2:end)]
locmaxINT2=[loc3(2:end),loc4(1,2:end)'];
%% find peaks in int 3
figure()
 
subplot(2,1,1)
[pk3,loc3]=findpeaks(G7(51201:end,5), G7(51201:end,1), 'MinPeakDistance', 1.2, 'MinPeakHeight', 18.9);
RR_OEP2_3=(length(pk3))/2.06;
findpeaks(G7(51201:end,5), G7(51201:end,1), 'MinPeakDistance', 1.2, 'MinPeakHeight', 18.9);
xlabel("time [s]");
ylabel("Volume [L]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk4,loc4]=findpeaks([-I7_z3f(:)],(linspace(513,636.17,1478)), 'MinPeakHeight', 0.03);
findpeaks([-I7_z3f(:)],(linspace(513,636.17,1478)), 'MinPeakHeight', 0.03);
xlabel("time [s]");
ylabel("Integral of Pressure");
title("MAXIMA IN IOR");
RR_IOR2_3=(length(pk4))/2.06;
maxINT3=[[pk3(2:end-9);pk3(end-7); pk3(end-5:end-1)],[pk4(1:end-3)]]
locmaxINT3=[[loc3(2:end-9,1);loc3(end-7,1); loc3(end-5:end-1,1)],[loc4(1:end-3)']];
 
%% find minima in der 1
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[min1,loc1]=findpeaks(-y1, G7(10001:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', 0.3);
findpeaks(-y1, G7(10001:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', 0.3);
min1=-min1;
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min2,loc2]=findpeaks(pred1nd(1200:2520),(linspace(100,210,1321)), 'MinPeakDistance', 2,'MinPeakHeight', 0.1);
min2=-min2;
findpeaks(pred1nd(1200:2520),(linspace(100,210,1321)),'MinPeakDistance', 2, 'MinPeakHeight', 0.1);
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MINIMA IN IOR");
minDER1=[min1(:), min2(1:end)];
locminDER1=[loc1(:),loc2(1:end)'];
%% find minima in der 2
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[min1,loc1]=findpeaks([-y2], G7(21001:51301,1), 'MinPeakDistance', 0.92, 'MinPeakHeight',1);
findpeaks([-y2], G7(21001:51301,1), 'MinPeakDistance', 0.92, 'MinPeakHeight', 1);
min1=-min1;
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min2,loc2]=findpeaks(pred1nd(2520:6156),(linspace(210,513,3637)), 'MinPeakDistance', 0.95,'MinPeakHeight', -0.4);
min2=-min2;
findpeaks(pred1nd(2520:6156),(linspace(210,513,3637)),'MinPeakDistance', 0.95, 'MinPeakHeight', -0.4);
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MINIMA IN IOR");
minDER2=[[min1(1:2);min1(4:end)], [min2(2:end)]];
locminDER2=[[loc1(1:2);loc1(4:end) ],[loc2(2:end)']];
 
%% find minima in der 3
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[min1,loc1]=findpeaks(-y3, G7(51301:end,1), 'MinPeakDistance', 1.1, 'MinPeakHeight', 0.8);
min1=-min1;
findpeaks([-y3], G7(51301:end,1), 'MinPeakDistance', 1.1, 'MinPeakHeight', 0.8);
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min2,loc2]=findpeaks(pred1nd(6156:end),(linspace(513,636.16,1478)), 'MinPeakDistance', 1,'MinPeakHeight', 0);
min2=-min2;
findpeaks(pred1nd(6156:end),(linspace(513,636.16,1478)),'MinPeakDistance', 1, 'MinPeakHeight', 0);
minDER3=[min1(:), [min2(1:3);min2(5:end-9); min2(end-7:end-2)]];
locminDER3=[loc1(:),[loc2(1:3)'; loc2(5:end-9)'; loc2(end-7:end-2)']];
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MINIMA IN IOR");
%% find minima in integral 1
figure()
 
subplot(2,1,1)
[min3,loc3]=findpeaks(-G7(10051:21001,5), G7(10051:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', -19);
min3=-min3;
findpeaks(-G7(10051:21001,5), G7(10051:21001,1), 'MinPeakDistance', 2, 'MinPeakHeight', -19);
xlabel("time [s]");
ylabel("Volume [L]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min4,loc4]=findpeaks([I7_z1f(:)],(linspace(100,210,1321)),  'MinPeakDistance', 2, 'MinPeakHeight', 0.03);
min4=-min4;
findpeaks([I7_z1f(:)],(linspace(100,210,1321)), 'MinPeakDistance', 2,  'MinPeakHeight', 0.03);
xlabel("time [s]");
ylabel("Integral of Pressure");
title("MINIMA IN IOR");
minINT1=[min3(1:end), min4(1:end)];
locminINT1=[loc3(1:end),loc4(1,1:end)'];
%% find minima in int 2
figure()
 
subplot(2,1,1)
[min3,loc3]=findpeaks(-G7(20801:51301,5), G7(20801:51301,1), 'MinPeakDistance', 1, 'MinPeakHeight', -18.7);
min3=-min3;
findpeaks(-G7(20801:51301,5), G7(20801:51301,1), 'MinPeakDistance', 1, 'MinPeakHeight', -18.7);
xlabel("time [s]");
ylabel("Volume [L]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min4,loc4]=findpeaks([I7_z2f(:)],(linspace(210,513,3637)), 'MinPeakHeight', -0.5);
min4=-min4;
findpeaks([I7_z2f(:)],(linspace(210,513,3637)), 'MinPeakHeight', -0.5);
xlabel("time [s]");
ylabel("Integral of Pressure");
title("MINIMA IN IOR");
minINT2=[min3, min4(1:end)]
locminINT2=[loc3,loc4(1,1:end)'];
%% find minima in int 3
figure()
 
subplot(2,1,1)
[min3,loc3]=findpeaks(-G7(51201:end,5), G7(51201:end,1), 'MinPeakDistance', 1, 'MinPeakHeight',-19);
min3=-min3;
findpeaks(-G7(51201:end,5), G7(51201:end,1), 'MinPeakDistance', 1, 'MinPeakHeight', -19);
xlabel("time [s]");
ylabel("Volume [L]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min4,loc4]=findpeaks([I7_z3f(:)],(linspace(513,636.17,1478)), 'MinPeakHeight', 0.03);
min4=-min4;
findpeaks([I7_z3f(:)],(linspace(513,636.17,1478)), 'MinPeakHeight', 0.03);
xlabel("time [s]");
ylabel("Integral of Pressure");
title("MINIMA IN IOR");
minINT3=[min3(2:end), min4(1:end-1)];
locminINT3=[loc3(2:end),loc4(1:end-1)'];
%% serie temporale totale
A_DER_OEP_1=abs(minDER1(:,1)-maxDER1(1:end-1,1));
A_DER_OEP_REL_1=(A_DER_OEP_1)/mean(A_DER_OEP_1);
A_DER_IOR_1=abs(minDER1(:,2)-maxDER1(1:end-1,2));
A_DER_IOR_REL_1=(A_DER_IOR_1)/mean(A_DER_IOR_1);
 
A_DER_REL_1=[A_DER_OEP_REL_1, A_DER_IOR_REL_1];
Err_DER_1_R= (A_DER_OEP_REL_1 - A_DER_IOR_REL_1);
ERR_DER_QUAD_MEAN_1_R=sqrt(mean((A_DER_OEP_REL_1 - A_DER_IOR_REL_1).^2))
Err_DER_MEAN1_R=mean(Err_DER_1_R);
R_DER_R_1=corrcoef(A_DER_OEP_REL_1, A_DER_IOR_REL_1);
 
 
A_INT_OEP_1=abs(maxINT1(1:end,1)-minINT1(1:end,1));
A_INT_OEP_REL_1=(A_INT_OEP_1)/mean(A_INT_OEP_1);
A_INT_IOR_1=abs(maxINT1(1:end,2)-minINT1(1:end,2));
A_INT_IOR_REL_1=(A_INT_IOR_1)/mean(A_INT_IOR_1);
 
A_INT_1=[A_INT_OEP_REL_1, A_INT_IOR_REL_1];

Err_INT_1_R = (A_INT_OEP_REL_1 - A_INT_IOR_REL_1);
ERR_INT_QUAD_MEAN_1_R=sqrt(mean((A_INT_OEP_REL_1 - A_INT_IOR_REL_1).^2))
R_INT_R_1=corrcoef(A_INT_OEP_REL_1, A_INT_IOR_REL_1);
Err_INT_MEAN1_R=mean(Err_INT_1_R);
EUCL_DER_1_R=norm(A_DER_OEP_REL_1 - A_DER_IOR_REL_1);
EUCL_INT_1_R=norm(A_INT_OEP_REL_1 - A_INT_IOR_REL_1);
 
A_DER_OEP_2=abs(minDER2(1:end,1)-maxDER2(1:end,1));
A_DER_OEP_REL_2=(A_DER_OEP_2)/mean(A_DER_OEP_1);
A_DER_IOR_2=abs(minDER2(1:end,2)-maxDER2(1:end,2));
A_DER_IOR_REL_2=(A_DER_IOR_2)/mean(A_DER_IOR_1);
 
A_DER_REL_2=[A_DER_OEP_REL_2, A_DER_IOR_REL_2];
Err_DER_2_R= (A_DER_OEP_REL_2 - A_DER_IOR_REL_2);
ERR_DER_QUAD_MEAN_2_R=sqrt(mean((A_DER_OEP_REL_2 - A_DER_IOR_REL_2).^2))
Err_DER_MEAN2_R=mean(Err_DER_2_R);
R_DER_R_2=corrcoef(A_DER_OEP_REL_2, A_DER_IOR_REL_2);
 
 
A_INT_OEP_2=abs(maxINT2(1:end,1)-minINT2(1:end-1,1));
A_INT_OEP_REL_2=(A_INT_OEP_2)/mean(A_INT_OEP_1);
A_INT_IOR_2=abs(maxINT2(1:end,2)-minINT2(1:end-1,2));
A_INT_IOR_REL_2=(A_INT_IOR_2)/mean(A_INT_IOR_1);
 
A_INT_2=[A_INT_OEP_REL_2, A_INT_IOR_REL_2];

Err_INT_2_R = (A_INT_OEP_REL_2 - A_INT_IOR_REL_2);
ERR_INT_QUAD_MEAN_2_R=sqrt(mean((A_INT_OEP_REL_2 - A_INT_IOR_REL_2).^2))
R_INT_R_2=corrcoef(A_INT_OEP_REL_2, A_INT_IOR_REL_2);
Err_INT_MEAN2_R=mean(Err_INT_2_R);
EUCL_DER_2_R=norm(A_DER_OEP_REL_2 - A_DER_IOR_REL_2);
EUCL_INT_2_R=norm(A_INT_OEP_REL_2 - A_INT_IOR_REL_2);
 
 
A_DER_OEP_3=abs(minDER3(:,1)-maxDER3(1:end,1));
A_DER_OEP_REL_3=(A_DER_OEP_3)/mean(A_DER_OEP_1);
A_DER_IOR_3=abs(minDER3(:,2)-maxDER3(1:end,2));
A_DER_IOR_REL_3=(A_DER_IOR_3)/mean(A_DER_IOR_1);
 
A_DER_REL_3=[A_DER_OEP_REL_3, A_DER_IOR_REL_3];
Err_DER_3_R= (A_DER_OEP_REL_3 - A_DER_IOR_REL_3);
ERR_DER_QUAD_MEAN_3_R=sqrt(mean((A_DER_OEP_REL_3 - A_DER_IOR_REL_3).^2))
Err_DER_MEAN3_R=mean(Err_DER_3_R);
R_DER_R_3=corrcoef(A_DER_OEP_REL_3, A_DER_IOR_REL_3);
 
 
A_INT_OEP_3=abs(maxINT3(1:end,1)-minINT3(1:end-1,1));
A_INT_OEP_REL_3=(A_INT_OEP_3)/mean(A_INT_OEP_1);
A_INT_IOR_3=abs(maxINT3(1:end,2)-minINT3(1:end-1,2));
A_INT_IOR_REL_3=(A_INT_IOR_3)/mean(A_INT_IOR_1);
 
A_INT_3=[A_INT_OEP_REL_3, A_INT_IOR_REL_3];

Err_INT_3_R = (A_INT_OEP_REL_3 - A_INT_IOR_REL_3);
ERR_INT_QUAD_MEAN_3_R=sqrt(mean((A_INT_OEP_REL_3 - A_INT_IOR_REL_3).^2))
R_INT_R_3=corrcoef(A_INT_OEP_REL_3, A_INT_IOR_REL_3);
Err_INT_MEAN3_R=mean(Err_INT_3_R);
EUCL_DER_3_R=norm(A_DER_OEP_REL_3 - A_DER_IOR_REL_3);
EUCL_INT_3_R=norm(A_INT_OEP_REL_3 - A_INT_IOR_REL_3);


A_DER_OEP_1=abs(minDER1(:,1)-maxDER1(1:end-1,1));
A_DER_IOR_1=abs(minDER1(:,2)-maxDER1(1:end-1,2));
A_DER_1=[A_DER_OEP_1, A_DER_IOR_1];
Err_DER_1= (A_DER_OEP_1 - A_DER_IOR_1);

Err_DER_MEAN1=mean(Err_DER_1);
Err_DER_MEAN1_REL=Err_DER_MEAN1./mean(A_DER_IOR_1);
R_DER_1=corrcoef(A_DER_OEP_1, A_DER_IOR_1);
A_INT_OEP_1=abs(maxINT1(1:end,1)-minINT1(1:end,1));
A_INT_IOR_1=abs(maxINT1(1:end,2)-minINT1(1:end,2));
A_INT_1=[A_INT_OEP_1, A_INT_IOR_1];
Err_INT_1 = (A_INT_OEP_1 - A_INT_IOR_1);

R_INT_1=corrcoef(A_INT_OEP_1, A_INT_IOR_1);
Err_INT_MEAN1=mean(Err_INT_1);
Err_INT_MEAN1_REL=Err_INT_MEAN1./mean(A_INT_IOR_1);
EUCL_DER_1=norm(A_DER_OEP_1 - A_DER_IOR_1);
EUCL_INT_1=norm(A_INT_OEP_1 - A_INT_IOR_1);

A_DER_OEP_2=abs(minDER2(:,1)-maxDER2(1:end,1));
A_DER_IOR_2=abs(minDER2(:,2)-maxDER2(1:end,2));
A_DER_2=[A_DER_OEP_2, A_DER_IOR_2];
Err_DER_2= (A_DER_OEP_2 - A_DER_IOR_2);

Err_DER_MEAN2=mean(Err_DER_2);
Err_DER_MEAN2_REL=Err_DER_MEAN2./mean(A_DER_IOR_2);
R_DER_2=corrcoef(A_DER_OEP_2, A_DER_IOR_2);
A_INT_OEP_2=abs(maxINT2(1:end,1)-minINT2(1:end-1,1));
A_INT_IOR_2=abs(maxINT2(1:end,2)-minINT2(1:end-1,2));
A_INT_2=[A_INT_OEP_2, A_INT_IOR_2];
Err_INT_2 = (A_INT_OEP_2 - A_INT_IOR_2);

R_INT_2=corrcoef(A_INT_OEP_2, A_INT_IOR_2);
Err_INT_MEAN2=mean(Err_INT_2);
Err_INT_MEAN2_REL=Err_INT_MEAN2./mean(A_INT_IOR_2);
EUCL_DER_2=norm(A_DER_OEP_2 - A_DER_IOR_2);
EUCL_INT_2=norm(A_INT_OEP_2 - A_INT_IOR_2);

A_DER_OEP_3=abs(minDER3(:,1)-maxDER3(1:end,1));
A_DER_IOR_3=abs(minDER3(:,2)-maxDER3(1:end,2));
A_DER_3=[A_DER_OEP_3, A_DER_IOR_3];
Err_DER_3= (A_DER_OEP_3 - A_DER_IOR_3);

Err_DER_MEAN3=mean(Err_DER_3);
Err_DER_MEAN3_REL=Err_DER_MEAN3./mean(A_DER_IOR_3);
R_DER_3=corrcoef(A_DER_OEP_3, A_DER_IOR_3);
A_INT_OEP_3=abs(maxINT3(1:end,1)-minINT3(1:end-1,1));
A_INT_IOR_3=abs(maxINT3(1:end,2)-minINT3(1:end-1,2));
A_INT_3=[A_INT_OEP_3, A_INT_IOR_3];
Err_INT_3 = (A_INT_OEP_3 - A_INT_IOR_3);

R_INT_3=corrcoef(A_INT_OEP_3, A_INT_IOR_3);
Err_INT_MEAN3=mean(Err_INT_3);
Err_INT_MEAN3_REL=Err_INT_MEAN3./mean(A_INT_IOR_3);
EUCL_DER_3=norm(A_DER_OEP_3 - A_DER_IOR_3);
EUCL_INT_3=norm(A_INT_OEP_3 - A_INT_IOR_3);
%%
figure(); plot([A_DER_IOR_1;A_DER_IOR_2;A_DER_IOR_3] , '*b'); hold on; plot([A_DER_OEP_1;A_DER_OEP_2;A_DER_OEP_3], 'or');
title ('IOR VS DERIVATIVE OF OEP - ASS');

figure(); plot([A_INT_IOR_1;A_INT_IOR_2;A_INT_IOR_3], '*b'); hold on; plot([A_INT_OEP_1;A_INT_OEP_2;A_INT_OEP_3], 'or');
title('INTEGRAL OF IOR VS OEP - ASS');

figure(); plot([A_DER_IOR_REL_1;A_DER_IOR_REL_2;A_DER_IOR_REL_3] , '*b'); hold on; plot([A_DER_OEP_REL_1;A_DER_OEP_REL_2;A_DER_OEP_REL_3], 'or');
title ('IOR VS DERIVATIVE OF OEP - REL');

figure(); plot([A_INT_IOR_REL_1;A_INT_IOR_REL_2;A_INT_IOR_REL_3], '*b'); hold on; plot([A_INT_OEP_REL_1;A_INT_OEP_REL_2;A_INT_OEP_REL_3], 'or');
title('INTEGRAL OF IOR VS OEP - REL');
% 
% figure(); plot(A_DER_IOR_2, '*r'); hold on; plot(A_DER_OEP_2, 'ob');
% title ('IOR VS DERIVATIVE OF OEP - ASS ');
% 
% figure(); plot(A_INT_IOR_2, '*r'); hold on; plot(A_INT_OEP_2, 'ob');
% title('INTEGRAL OF IOR VS OEP – ASS');
% 
% figure(); plot(A_DER_IOR_3, '*r'); hold on; plot(A_DER_OEP_3, 'ob');
% title ('IOR VS DERIVATIVE OF OEP - ASS ');

% figure(); plot(A_INT_IOR_3, '*r'); hold on; plot(A_INT_OEP_3, 'ob');
% title('INTEGRAL OF IOR VS OEP – ASS');
% 
% 
% figure(); plot(A_DER_IOR_REL_1, '*r'); hold on; plot(A_DER_OEP_REL_1, 'ob');
% title ('IOR VS DERIVATIVE OF OEP - REL ');
% 
% figure(); plot(A_INT_IOR_REL_1, '*r'); hold on; plot(A_INT_OEP_REL_1, 'ob');
% title('INTEGRAL OF IOR VS OEP - REL');
% 
% figure(); plot(A_DER_IOR_REL_2, '*r'); hold on; plot(A_DER_OEP_REL_2, 'ob');
% title ('IOR VS DERIVATIVE OF OEP - REL ');
% 
% figure(); plot(A_INT_IOR_REL_2, '*r'); hold on; plot(A_INT_OEP_REL_2, 'ob');
% title('INTEGRAL OF IOR VS OEP - REL');
% 
% figure(); plot(A_DER_IOR_REL_3, '*r'); hold on; plot(A_DER_OEP_REL_3, 'ob');
% title ('IOR VS DERIVATIVE OF OEP - REL ');
% 
% figure(); plot(A_INT_IOR_REL_3, '*r'); hold on; plot(A_INT_OEP_REL_3, 'ob');
% title('INTEGRAL OF IOR VS OEP - REL');


 


%% svc
fc = 1;
fs = 100;
[b,a] = butter(5,fc/(fs/2));
g=(gradient(G7(:,5))/0.01);
y=filtfilt(b,a,(gradient(G7(:,5))/0.01));

figure()
plot(G7(1:10000,1),g(1:10000),'--r');
hold on 
plot(G7(1:10000,1), G7( (1:10000),5)-mean(G7( (1:10000),5)), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('DERIVATIVE SVC WITH DIFF VS OEP SIGNAL');
legend('derivative of volume', 'Volume');

figure()
yyaxis left
plot((linspace(0,100,1200)), pred1nd(1:1200)); %%evaluate whether to seprate SVC
title("Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(1:10000,1),[y(1:10000)], '--r');
ylabel("Flow [L/s]");

figure()
yyaxis left
plot((linspace(0,100,1200)), -pred1nd(1:1200)); %%evaluate whether to seprate SVC
title("2 Intra-Oral Respirometer (Pressure) vs OEP (Flow = DVolume)");
xlabel("time [s]")
ylabel("Pressure [cmH2O]");
hold on
yyaxis right
plot(G7(1:10000,1),[y(1:10000)], '--r');
ylabel("Flow [L/s]");
%%
I_SVC=(cumsum(pred1nd(1:1200)))*1/12;
%
%load("I_svcW.mat");
 fc = 1;
fs = 12;
[b,a] = butter(5,fc/(fs/2));
 
figure()
plot((detrend(I_SVC,3)), '--r');
hold on 
plot (pred1nd(1:1200), 'b');
ylabel("Pressure [cmH2O]",'Color','b');
xlabel("Samples");
title('INTEGRAL SVC VS PRESSURE SIGNAL');
legend('integral of pressure', 'pressure');
 
I_SVCf=filtfilt(b,a,detrend(I_SVC,3));
figure()
plot(detrend(I_SVC,3), 'b')
hold on 
plot(I_SVCf, '--r');
legend("integral", "filtered integral");
title("INTEGRAL AND FILTERED INTEGRAL")


figure()
yyaxis left
plot((linspace(0,100,1200))', detrend(I_SVC,3)); %%evaluate whether to seprate SVC
title("Intra-Oral Respirometer (Integral of Pressure) vs OEP (Volume)");
xlabel("time [s]")
ylabel("Integral of pressure");
hold on
yyaxis right
plot(G7(1:10000,1),G7(1:10000,5), '--r');
ylabel("Volume [L]");
 
figure()
yyaxis left
plot((linspace(0,100,1200))', -detrend(I_SVC,3)); %%evaluate whether to seprate SVC
title("2Intra-Oral Respirometer (Integral of Pressure) vs OEP (Volume)");
xlabel("time [s]")
ylabel("Integral of pressure");
hold on
yyaxis right
plot(G7(1:10000,1),G7(1:10000,5), '--r');
ylabel("Volume [L]");
 
%% MAX AND MIN IN DER 
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[pk1,loc1]=findpeaks(y(1:10000), G7(1:10000,1), 'MinPeakDistance', 2.2, 'MinPeakHeight', 0.6);
findpeaks([y(1:10000)], G7(1:10000,1), 'MinPeakDistance', 2.2, 'MinPeakHeight', 0.6);
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk2,loc2]=findpeaks(pred1nd(1:1200),(linspace(0,100,1200)), 'MinPeakDistance', 2,'MinPeakHeight', 0.9);
findpeaks(pred1nd(1:1200),(linspace(0,100,1200)),'MinPeakDistance', 2, 'MinPeakHeight', 0.9);
maxDERSVC=[pk1(1:end), pk2(5:end)];
locmaxDERSVC=[loc1(1:end),loc2(5:end)'];
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MAXIMA IN IOR");
%%
figure()
%plot(G1(:,1),[0;0;0;0;0;0;dG1]);
subplot(2,1,1)
[min1,loc1]=findpeaks(-y(1:10000), G7(1:10000,1), 'MinPeakDistance', 2.3, 'MinPeakHeight', 0.6);
min1=-min1;
findpeaks(-y(1:10000), G7(1:10000,1), 'MinPeakDistance', 2.3, 'MinPeakHeight', 0.6);
xlabel("time [s]");
ylabel("Flow [L/s]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min2,loc2]=findpeaks(-pred1nd(1:1200),(linspace(0,100,1200)), 'MinPeakDistance', 2,'MinPeakHeight', 0.5);
min2=-min2;
findpeaks(-pred1nd(1:1200),(linspace(0,100,1200)),'MinPeakDistance', 2, 'MinPeakHeight', 0.5);
minDERSVC=[min1(1:end), min2(1:end)];
locminDERSVC=[loc1(1:end),loc2(1:end)'];
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
title("MINIMA IN IOR");
%% MAX AND MIN IN INT
figure()
subplot(2,1,1)
[pk3,loc3]=findpeaks(G7(1:10000,5), G7(1:10000,1), 'MinPeakDistance', 2, 'MinPeakHeight', 19);
findpeaks(G7(1:10000,5), G7(1:10000,1), 'MinPeakDistance', 2, 'MinPeakHeight', 19);
xlabel("time [s]");
ylabel("Volume [L]");
title("MAXIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[pk4,loc4]=findpeaks(I_SVCf,linspace(0,100,1200), 'MinPeakDistance', 2,'MinPeakHeight',-1);
findpeaks(I_SVCf, linspace(0,100,1200), 'MinPeakDistance', 2,'MinPeakHeight', -1);
xlabel("time [s]");
ylabel("Pressure [cmH2O]");
ylabel("Integral of Pressure");
title("MAXIMA IN IOR");
 
maxINTSVC=[pk3(1:end), [pk4(4:end-12);pk4(end-10:end)]]
locmaxINTSVC=[loc3(1:end),[loc4(1,4:end-12)';loc4(1,end-10:end)'] ];
%%
figure()
 
subplot(2,1,1)
[min3,loc3]=findpeaks(-G7(1:10000,5), G7(1:10000,1), 'MinPeakDistance', 2, 'MinPeakHeight',-19);
min3=-min3;
findpeaks(-G7(1:10000,5), G7(1:10000,1), 'MinPeakDistance', 2, 'MinPeakHeight', -19);
xlabel("time [s]");
ylabel("Volume [L]");
title("MINIMA IN OEP");
subplot(2,1,2)
%plot((linspace(0,314.84, 3778))', [zeros(24,1);pressure1Wnodeglab],'b');
[min4,loc4]=findpeaks(I_SVCf, linspace(0,100,1200), 'MinPeakDistance', 2, 'MinPeakHeight', -1);
min4=-min4;
findpeaks(I_SVCf,linspace(0,100,1200),  'MinPeakDistance', 2,'MinPeakHeight', -1);
xlabel("time [s]");
ylabel("Integral of Pressure");
title("MINIMA IN IOR");
minINTSVC=[[min3(6:end-13); min3(end-10:end)], [min4(4:end-12); min4(end-10:end)]]
locminINTSVC=[[loc3(6:end-13);loc3(end-10:end)] ,[loc4(4:end-12)'; loc4(end-10:end)']];

%% SERIE TEMPORALE
A_DER_OEP=abs(maxDERSVC(1:end,1)-minDERSVC(:,1));
A_DER_OEP_REL=(A_DER_OEP)/mean(A_DER_OEP);
A_DER_IOR=abs(maxDERSVC(1:end,2)-minDERSVC(:,2));
A_DER_IOR_REL=(A_DER_IOR)/mean(A_DER_IOR);
 
A_DER_REL=[A_DER_OEP_REL, A_DER_IOR_REL];
  
Err_DER_SVC =mean (A_DER_OEP - A_DER_IOR);
Err_DER_SVC_R = mean(A_DER_OEP_REL - A_DER_IOR_REL);
Err_DER_REL_SVC= Err_DER_SVC./A_DER_IOR_REL;
Err_DER_MEAN_SVC=mean(Err_DER_SVC);
R_DER_SVC=corrcoef(A_DER_OEP_REL, A_DER_IOR_REL);
 ERR_DER_QUAD_MEAN_SVC_R=sqrt(mean((A_DER_OEP_REL - A_DER_IOR_REL).^2))
A_INT_OEP=abs(maxINTSVC(1:end,1)-minINTSVC(1:end,1));
A_INT_OEP_REL=(A_INT_OEP)/mean(A_INT_OEP);
A_INT_IOR=abs(maxINTSVC(1:end,2)-minINTSVC(1:end,2));
A_INT_IOR_REL=(A_INT_IOR)/mean(A_INT_IOR);
 
A_INT=[A_INT_OEP_REL, A_INT_IOR_REL];
 Err_INT_SVc = mean(A_INT_OEP - A_INT_IOR);
Err_INT_SVC_R =mean (A_INT_OEP_REL - A_INT_IOR_REL);
Err_INT_REL_SVC= Err_INT_SVc./A_INT_IOR_REL;
Err_INT_MEAN_SVC=mean(Err_INT_SVc);
 ERR_INT_QUAD_MEAN_SVC_R=sqrt(mean((A_INT_OEP_REL - A_INT_IOR_REL).^2))
R_INT_SVC=corrcoef(A_INT_OEP_REL, A_INT_IOR_REL);
 
 
Err_DER_R_ABSVAL_SVC = abs(Err_DER_SVC_R)
Err_DER_MEAN_R_ABSVAL_SVC=mean(Err_DER_R_ABSVAL_SVC);
Err_INT_R_ABSVAL_SVC = abs(Err_INT_SVC_R);
Err_INT_MEAN_R_ABSVAL_SVC=mean(Err_INT_R_ABSVAL_SVC);
Err_DER_ABSVAL_SVC = abs(Err_DER_SVC);
Err_DER_MEAN_ABSVAL_SVC=mean(Err_DER_ABSVAL_SVC);
Err_INT_ABSVAL_SVC = abs(Err_INT_SVc);
Err_INT_MEAN_ABSVAL_SVC=mean(Err_INT_ABSVAL_SVC);
%%
figure(); plot(A_DER_IOR, '*b'); hold on; plot(A_DER_OEP, 'or');
title ('IOR VS DERIVATIVE OF OEP - ASS ');

figure(); plot(A_INT_IOR, '*b'); hold on; plot(A_INT_OEP, 'or');
title('INTEGRAL OF IOR VS OEP - ASS')

figure(); plot(A_DER_IOR_REL, '*b'); hold on; plot(A_DER_OEP_REL, 'or');
title ('IOR VS DERIVATIVE OF OEP - REL ');

figure(); plot(A_INT_IOR_REL, '*b'); hold on; plot(A_INT_OEP_REL, 'or');
title('INTEGRAL OF IOR VS OEP - REL');
%%
%  rVOLUME=resample(G7(10001:end,5),3,25);
% rTIMEVOLUME=resample(G7(10001:end,1),3,25);
% rDVOLUME=resample(y(10001:end),3,25);
% 
% % Err_DER=pred1nd(1:3791)-[zeros(17,1);rDVOLUME(1:end-17)];
% % Err_INT=I2_zf(1:3791)-[zeros(17,1);(rVOLUME(1:end-17)-mean(rVOLUME(1:end-17)))];
% 
% Err_DER=pred1nd(1:6387)-[zeros(20,1);rDVOLUME(1:end-20)];
% %Err_INT=I7_zf(1:6387)-[zeros(20,1);(rVOLUME(1:end-20)-mean(rVOLUME(1:end-20)))];
% %%
% figure();
% %plot(Err_DER, '-or');
% hold on
% plot([zeros(18,1);rDVOLUME(1:end-18)], 'b');
% hold on
% plot(pred1nd(1201:(7587)), 'k');
% %%
% figure()
% rDVOLUME=resample(y(10001:end),3,25);
% plot(pred1nd(1201:7587) ,[zeros(18,1);rDVOLUME(1:end-18)], '->')
% xlabel("Flow [L/s]");
% ylabel("Pressure [cmH2O]");
% hold on
% xline(0,'k');
% hold on 
% yline(0, 'k');
%%
load("minSPONT.mat");
load("maxSPONT.mat");
figure()
maxDER=[maxDER1; maxDER2;maxDER3];
minDER=[minDER1; minDER2;minDER3];
% rDVOLUME=resample(y,3,25);
plot(maxDER(:,1) ,maxDER(:,2) , 'ob')
hold on 
plot(minDER(:,1), minDER(:,2), 'ob')
% xlabel("Flow [L/s]");
% ylabel("Pressure [cmH2O]");
% hold on 
% plot(maxSPONT(:,1) ,maxSPONT(:,2), '*r')
% hold on 
% plot(minSPONT(:,1), minSPONT(:,2), '*r')
xlabel("Flow [L/s]");
ylabel("Pressure [cmH2O]");
hold on
xline(0,'k');
hold on 
yline(0, 'k');
% legend('Spontaneous', '', 'Exercise');

maxEX=maxDER;
minEX=minDER;
%%
%saveallfigs('C:\Users\Giulia\Desktop\GIULIA\POLIMI\Thesis_1\PLOT_12 NOVEMBRE\BICYCLE') 

 
Err_DER_R_ABSVAL_1 = abs(Err_DER_1_R);
Err_DER_MEAN_R_ABSVAL_1=mean(Err_DER_R_ABSVAL_1);
Err_INT_R_ABSVAL_1 = abs(Err_INT_1_R);
Err_INT_MEAN_R_ABSVAL_1=mean(Err_INT_R_ABSVAL_1);
Err_DER_ABSVAL_1 = abs(Err_DER_1);
Err_DER_MEAN_ABSVAL_1=mean(Err_DER_ABSVAL_1);
Err_INT_ABSVAL_1 = abs(Err_INT_1);
Err_INT_MEAN_ABSVAL_1=mean(Err_INT_ABSVAL_1);

Err_DER_R_ABSVAL_2 = abs(Err_DER_2_R);
Err_DER_MEAN_R_ABSVAL_2=mean(Err_DER_R_ABSVAL_2);
Err_INT_R_ABSVAL_2 = abs(Err_INT_2_R);
Err_INT_MEAN_R_ABSVAL_2=mean(Err_INT_R_ABSVAL_2);
Err_DER_ABSVAL_2 = abs(Err_DER_2);
Err_DER_MEAN_ABSVAL_2=mean(Err_DER_ABSVAL_2);
Err_INT_ABSVAL_2 = abs(Err_INT_2);
Err_INT_MEAN_ABSVAL_2=mean(Err_INT_ABSVAL_2);

Err_DER_R_ABSVAL_3 = abs(Err_DER_3_R);
Err_DER_MEAN_R_ABSVAL_3=mean(Err_DER_R_ABSVAL_3);
Err_INT_R_ABSVAL_3 = abs(Err_INT_3_R);
Err_INT_MEAN_R_ABSVAL_3=mean(Err_INT_R_ABSVAL_3);
Err_DER_ABSVAL_3 = abs(Err_DER_3);
Err_DER_MEAN_ABSVAL_3=mean(Err_DER_ABSVAL_3);
Err_INT_ABSVAL_3 = abs(Err_INT_3);
Err_INT_MEAN_ABSVAL_3=mean(Err_INT_ABSVAL_3);
