addpath('C:\Users\zmhua\Documents\MATLAB\data','functions');
DIS=csvread('DIS.csv');
name='DIS';
%-------EXCERCISE 2 --------------

% create a dates_prices matrix
[DIS_dates,DIS_lprices]=load_stock('DIS.csv','m');
N_DIS=sum(DIS(1,1)==DIS(:,1));% number of observations per day
% calculate stock log-return and return dates
[DIS_rdates,DIS_lr]=log_return([DIS_dates,DIS_lprices],N_DIS,1);

%Part A
% calculate RV
rv_DIS=realized_var(DIS_lr);
DIS_days=unique(floor(DIS_rdates));
% plot RV
figure;
plot(DIS_days,rv_DIS);%plot annual rv
xlim([min(DIS_days),max(DIS_days)]);
xlabel('Year');
ylabel('Annual RV(\%)');
title(['Annual RV of ' name '(\%)']);
datetick('x','keeplimits');%transfer the x-axis format

%Part B
% calculate BV
bv_DIS=bipower_var(DIS_lr); 
% plot BV
figure;
plot(DIS_days,bv_DIS);
xlim([min(DIS_days),max(DIS_days)]);
xlabel('Year');
ylabel('Annual BV(\%)');
title(['Annual BV of ' name '(\%)']);
datetick('x','keeplimits');

%Part C
% plot RV & BV
figure;
plot(DIS_days,rv_DIS,'-r');
hold on;
plot(DIS_days,bv_DIS,'b');
xlim([min(DIS_days),max(DIS_days)]);
xlabel('Year');
ylabel('Annual BV and RV');
title(['Annual BV and RV of ' name '(\%)']);
legend('RV(\%)','BV(\%)');
datetick('x','keeplimits');

%Part D
% calculate contribution of jumps
Ct_DIS=max(rv_DIS-bv_DIS,0)./rv_DIS;
C_DIS=mean(Ct_DIS);
% plot Ct
figure;
plot(DIS_days,100*Ct_DIS);
xlim([min(DIS_days),max(DIS_days)]);
xlabel('Year');
ylabel('Ct(\%)');
title(['Contribution of jumps of ' name '(\%)']);
datetick('x','keeplimits');



