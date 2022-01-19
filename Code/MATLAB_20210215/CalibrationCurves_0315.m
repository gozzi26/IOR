clear all
close all
% Manometer_exposed = readmatrix('2021_03_12-Manometer_Exposed_Test1.xlsx');
Manometer_exposed = readmatrix('2021_03_15-Manometer_Exposed_Test1.xlsx');
Calib_signal=Manometer_exposed(:,2);
t=linspace(0,(length(Calib_signal)-120)*(1/12)/60,(length(Calib_signal)));

figure
plot(t,Calib_signal) %plot(t,Calib_signal)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Calibration signal");

hold on
mean_atm_press=mean(Calib_signal(1:1488));
yl=yline(mean_atm_press, '--r', mean_atm_press);
yl.LabelHorizontalAlignment = 'left';

mean_intube = mean(Calib_signal(1600:2800));
yl=yline(mean_intube, '--r', mean_intube);
yl.LabelHorizontalAlignment = 'left';


mean1 = mean(Calib_signal(2950:3600));
mean2 = mean(Calib_signal(4000:4400));
mean3 = mean(Calib_signal(4500:5100));
mean4 = mean(Calib_signal(5230:5900));
mean5 = mean(Calib_signal(5990:6656));
mean6 = mean(Calib_signal(6700:7300));
mean7 = mean(Calib_signal(7400:7980));
mean8 = mean(Calib_signal(8200:8900));
mean9 = mean(Calib_signal(8980:9341));
mean10 = mean(Calib_signal(9720:10400));
mean11 = mean(Calib_signal(10460:11000));
mean12 = mean(Calib_signal(11100:11700));



yl=yline(mean1, '--r', mean1);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean2, '--r', mean2);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean3, '--r', mean3);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean4, '--r', mean4);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean5, '--r', mean5);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean6, '--r', mean6);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean7, '--r', mean7);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean8, '--r', mean8);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean9, '--r', mean9);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean10, '--r', mean10);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean11, '--r', mean11);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean12, '--r', mean12);
yl.LabelHorizontalAlignment = 'left';


vector_avg=[mean_intube mean1 mean2 mean3 mean4 mean5 mean6 mean7 mean8 mean9 mean10 mean11 mean12];
cmH2O = [0 1 2 3 4 5 6 7 8 9 10 11 12];
figure
plot (cmH2O,vector_avg,'*r')
xlabel("Manometer Pressure [cmH2O]")
ylabel("Pressure measured by the sensor [cmH2O]");
title("Calibration Curve - Sensor Exposed");
p=polyfit(cmH2O,vector_avg,1);
y1 = polyval(p,cmH2O);
hold on
plot(cmH2O,y1,'r')


%%
Manometer_Covered = readmatrix('2021_03_19_Calib1.xlsx');
Calib_signal=Manometer_Covered(:,2);
t=linspace(0,(length(Calib_signal)-120)*(1/12)/60,(length(Calib_signal)));

figure
plot(Calib_signal) %plot(t,Calib_signal)
xlabel("time [min]")
ylabel("Pressure [cmH2O]");
title("Calibration signal");

% hold on
% mean_atm_press=mean(Calib_signal(1:1488));
% yl=yline(mean_atm_press, '--r', mean_atm_press);
% yl.LabelHorizontalAlignment = 'left';

mean_intube = mean(Calib_signal(8:733));
yl=yline(mean_intube, '--r', mean_intube);
yl.LabelHorizontalAlignment = 'left';


mean1 = mean(Calib_signal(800:1481));
mean2 = mean(Calib_signal(1536:2218));
mean3 = mean(Calib_signal(2387:2999));
mean4 = mean(Calib_signal(3140:3731));
mean5 = mean(Calib_signal(4025:4430));
mean6 = mean(Calib_signal(4525:5142));
mean7 = mean(Calib_signal(5233:5824));
mean8 = mean(Calib_signal(6049:6568));
mean9 = mean(Calib_signal(7394:7457));
mean10 = mean(Calib_signal(7510:8052));
mean11 = mean(Calib_signal(8118:8517));
mean12 = mean(Calib_signal(8815:9318));



yl=yline(mean1, '--r', mean1);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean2, '--r', mean2);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean3, '--r', mean3);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean4, '--r', mean4);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean5, '--r', mean5);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean6, '--r', mean6);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean7, '--r', mean7);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean8, '--r', mean8);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean9, '--r', mean9);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean10, '--r', mean10);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean11, '--r', mean11);
yl.LabelHorizontalAlignment = 'left';
yl=yline(mean12, '--r', mean12);
yl.LabelHorizontalAlignment = 'left';


vector_avg_covered=[mean_intube mean1 mean2 mean3 mean4 mean5 mean6 mean7 mean8 mean9 mean10 mean11 mean12];
cmH2O = [0 1 2 3 4 5 6 7 8 9 10 11 12];
figure
plot (cmH2O,vector_avg_covered,'*k')
xlabel("Manometer Pressure [cmH2O]")
ylabel("Pressure measured by the sensor [cmH2O]");
title("Calibration Curve - Sensor with Polyimide Tape");
p_covered=polyfit(cmH2O,vector_avg_covered,1);
y1_covered = polyval(p_covered,cmH2O);
hold on
plot(cmH2O,y1_covered,'k')



figure
title("Calibration Curve");
xlabel("Manometer Pressure [cmH2O]")
ylabel("Pressure measured by the sensor [cmH2O]");
xlim([0 12])
ylim([-1 13])
hold on
% plot (vector_avg,'*r')
% hold on
p = plot(cmH2O,y1,cmH2O,y1_covered);
p(1).Marker = '*';
p(2).Marker = '*';
%plot(cmH2O,y1,'r-o')

%hold on

% plot (vector_avg_covered,'*k')
% hold on
%plot(cmH2O,y1_covered,'k-o')
legend("Sensor Exposed", "Sensor Covered with Polyimide Tape");