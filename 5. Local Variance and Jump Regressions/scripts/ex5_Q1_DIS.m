addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));

%A1
%local variance for n*T intervals
a=5;
kn=11;
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS,a);
ct_DIS=local_var(lr_c_DIS,kn);
%plot one day's local variance
figure;
subplot(2,1,1);
stairs(rdates_DIS(:,1),ct_DIS(:,1));
xlabel('time');
ylabel('local variance $\hat{c_{i_t}}$');
xlim([min(rdates_DIS(:,1)),max(rdates_DIS(:,1))]);
title('Stairs graph of local variance of DIS in January 3, 2007'); 
datetick('x','keeplimits');

subplot(2,1,2);
plot(rdates_DIS(:,1),ct_DIS(:,1));
xlabel('time');
ylabel('local variance $\hat{c_{i_t}}$');
xlim([min(rdates_DIS(:,1)),max(rdates_DIS(:,1))]);
title('Local variance of DIS in January 3, 2007'); 
datetick('x','keeplimits');

%1B
%average local variance
ct_avg_DIS=mean(transpose(ct_DIS));
%plot
figure;
plot(rdates_DIS(:,1),ct_avg_DIS);
xlabel('time');
ylabel('Avg. local variance $\bar{\hat{c}}$');
xlim([min(rdates_DIS(:,1)),max(rdates_DIS(:,1))]);
title('Average local variance of DIS'); 
datetick('x','keeplimits');





























