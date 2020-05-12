addpath('C:\Users\zmhua\Documents\MATLAB\data','functions');
DIS=csvread('DIS.csv');
name='DIS';
%-------EXCERCISE 1(DIS) --------------

%Part A
% get Y,M,D,H,MN,S
Y_DIS=floor(DIS(:,1)/10000); % year
M_DIS=floor((DIS(:,1)-Y_DIS*10000)/100); %month
D_DIS=DIS(:,1)-10000*Y_DIS-100*M_DIS; %day
% create a dates_prices matrix
[DIS_dates,DIS_lprices]=load_stock('DIS.csv','m');

%Part B
% calculate N and T
N_DIS=sum(DIS(1,1)==DIS(:,1));% number of observations per day
n_DIS=N_DIS-1; % number of intervals per day
T_DIS=size(DIS,1)/N_DIS; %number of days

%Part D
% calculate stock log-return and return dates
[DIS_rdates,DIS_lr]=log_return([DIS_dates,DIS_lprices],N_DIS,1);

%Part E
% plot price
figure;
plot(DIS_dates,exp(DIS_lprices));
xlim([min(DIS_dates),max(DIS_dates)]);
xlabel('Year');
ylabel('Price(dollars)');
title(['Price of ' name '(dollars)']);
datetick('x','keeplimits');
% plot log-return
figure;
plot(DIS_rdates(:),100*DIS_lr(:));
xlabel('Year');
ylabel('log-return(\%)');
title(['log-return of ' name '(\%)']);
xlim([min(DIS_rdates(:)),max(DIS_rdates(:))]);
datetick('x','keeplimits');%transfer the x-axis format


