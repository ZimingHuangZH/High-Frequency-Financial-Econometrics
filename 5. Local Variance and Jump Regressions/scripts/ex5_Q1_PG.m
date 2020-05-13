addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));

%A1
%local variance for n*T intervals
a=5;
kn=11;
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG,a);
ct_PG=local_var(lr_c_PG,kn);
%plot one day's local variance
figure;
subplot(2,1,1);
stairs(rdates_PG(:,1),ct_PG(:,1));
xlabel('time');
ylabel('local variance $\hat{c_{i_t}}$');
xlim([min(rdates_PG(:,1)),max(rdates_PG(:,1))]);
title('Stairs graph of local variance of PG in January 3, 2007'); 
datetick('x','keeplimits');

subplot(2,1,2);
plot(rdates_PG(:,1),ct_PG(:,1));
xlabel('time');
ylabel('local variance $\hat{c_{i_t}}$');
xlim([min(rdates_PG(:,1)),max(rdates_PG(:,1))]);
title('Local variance of PG in January 3, 2007'); 
datetick('x','keeplimits');

%1B
%average local variance
ct_avg_PG=mean(transpose(ct_PG));
%plot
figure;
plot(rdates_PG(:,1),ct_avg_PG);
xlabel('time');
ylabel('Avg. local variance $\bar{\hat{c}}$');
xlim([min(rdates_PG(:,1)),max(rdates_PG(:,1))]);
title('Average local variance of PG'); 
datetick('x','keeplimits');





























