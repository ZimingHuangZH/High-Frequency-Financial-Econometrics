addpath('C:\Users\zmhua\Documents\MATLAB\data','functions');
PG=csvread('PG.csv');
name='PG';
%-------EXCERCISE 2 --------------

% create a dates_prices matrix
[PG_dates,PG_lprices]=load_stock('PG.csv','m');
N_PG=sum(PG(1,1)==PG(:,1));% number of observations per day
% calculate stock log-return and return dates
[PG_rdates,PG_lr]=log_return([PG_dates,PG_lprices],N_PG,1);

%Part A
% calculate RV
rv_PG=realized_var(PG_lr);
PG_days=unique(floor(PG_rdates));
% plot RV
figure;
plot(PG_days,rv_PG);%plot annual rv
xlim([min(PG_days),max(PG_days)]);
xlabel('Year');
ylabel('Annual RV(\%)');
title(['Annual RV of ' name '(\%)']);
datetick('x','keeplimits');%transfer the x-axis format

%Part B
% calculate BV
bv_PG=bipower_var(PG_lr); 
% plot BV
figure;
plot(PG_days,bv_PG);
xlim([min(PG_days),max(PG_days)]);
xlabel('Year');
ylabel('Annual BV(\%)');
title(['Annual BV of ' name '(\%)']);
datetick('x','keeplimits');

%Part C
% plot RV & BV
figure;
plot(PG_days,rv_PG,'-r');
hold on;
plot(PG_days,bv_PG,'b');
xlim([min(PG_days),max(PG_days)]);
xlabel('Year');
ylabel('Annual BV and RV');
title(['Annual BV and RV of ' name '(\%)']);
legend('RV(\%)','BV(\%)');
datetick('x','keeplimits');

%Part D
% calculate contribution of jumps
Ct_PG=max(rv_PG-bv_PG,0)./rv_PG;
C_PG=mean(Ct_PG);
% plot Ct
figure;
plot(PG_days,100*Ct_PG);
xlim([min(PG_days),max(PG_days)]);
xlabel('Year');
ylabel('Ct(\%)');
title(['Contribution of jumps of ' name '(\%)']);
datetick('x','keeplimits');



