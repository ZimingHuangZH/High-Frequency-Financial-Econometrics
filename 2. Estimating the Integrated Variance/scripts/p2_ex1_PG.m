addpath('C:\Users\zmhua\Documents\MATLAB\data','functions');
PG=csvread('PG.csv');
name='PG';
%-------EXCERCISE 1(PG) --------------

%Part A
% get Y,M,D,H,MN,S
Y_PG=floor(PG(:,1)/10000); % year
M_PG=floor((PG(:,1)-Y_PG*10000)/100); %month
D_PG=PG(:,1)-10000*Y_PG-100*M_PG; %day
% create a dates_prices matrix
[PG_dates,PG_lprices]=load_stock('PG.csv','m');

%Part B
% calculate N and T
N_PG=sum(PG(1,1)==PG(:,1));% number of observations per day
n_PG=N_PG-1; % number of intervals per day
T_PG=size(PG,1)/N_PG; %number of days

%Part D
% calculate stock log-return and return dates
[PG_rdates,PG_lr]=log_return([PG_dates,PG_lprices],N_PG,1);

%Part E
% plot price
figure;
plot(PG_dates,exp(PG_lprices));
xlim([min(PG_dates),max(PG_dates)]);
xlabel('Year');
ylabel('Price(dollars)');
title(['Price of ' name '(dollars)']);
datetick('x','keeplimits');
% plot log-return
figure;
plot(PG_rdates(:),100*PG_lr(:));
xlabel('Year');
ylabel('log-return(\%)');
title(['log-return of ' name '(\%)']);
xlim([min(PG_rdates(:)),max(PG_rdates(:))]);
datetick('x','keeplimits');%transfer the x-axis format


