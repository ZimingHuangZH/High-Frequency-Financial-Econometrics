addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');

[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS,a);


[dates_SPY,lp_SPY]=load_stock('SPY.csv','m');
N_SPY=sum(floor(dates_SPY(1,1))==floor(dates_SPY(:,1)));% number of observations per day
T_SPY=size(dates_SPY,1)/N_SPY;
[rdates_SPY,lr_SPY]=log_return([dates_SPY lp_SPY],N_SPY,1);
days_SPY=unique(floor(rdates_SPY));
[lr_c_SPY,lr_d_SPY]=c_d_log_returns(lr_SPY,N_SPY,a);

%!!!
%if you want to check each scripts, you have to set the repeat time for this script
%otherwise, the code won't run successfully

a=4.5;
M=11;
n=N_DIS-1;
kn=(N_DIS-1)/M;
%(repeat time)
%r=10000;


%---part a
rbeta_DIS=realized_beta(lr_c_DIS, lr_c_SPY);

figure;
plot(days_DIS,rbeta_DIS);
xlabel('Day');
ylabel('Realized Beta');
title('Realized Beta over years for DIS');
xlim([min(days_DIS),max(days_DIS)]);
datetick('x','keeplimits');


%part c


sbeta=zeros(r,T_DIS);
parfor i=1:r
    [newsample1,newsample2]=bsample_2(lr_c_DIS,lr_c_SPY,kn,n,T_DIS);
    sbeta(i,:)=sum(newsample1.*newsample2)./sum(newsample2.^2);
end

CI_low_rbDIS = quantile(sbeta, 0.025);
CI_up_rbDIS = quantile(sbeta, 0.975);

%evaluate the estimated confidence interval
num_in_DIS=sum(CI_low_rbDIS <=rbeta_DIS & CI_up_rbDIS >=rbeta_DIS);
cover_rate_DIS=num_in_DIS/T_DIS;

figure;
plot(days_DIS,rbeta_DIS);
hold on;
plot(days_DIS,CI_low_rbDIS);
hold on;
plot(days_DIS,CI_up_rbDIS);
hold off;
xlabel('Day');
ylabel('Realized Beta');
title('Realized Beta and estimated confidence interval of DIS');
xlim([min(days_DIS),max(days_DIS)]);
legend('Realized Beta','CI\_rblow','CI\_rbup');
datetick('x','keeplimits');


%part d(zoom in a January 2007)
d=21;
figure;
plot(days_DIS(1:d),rbeta_DIS(1:d));
hold on;
plot(days_DIS(1:d),CI_low_rbDIS(1:d));
hold on;
plot(days_DIS(1:d),CI_up_rbDIS(1:d));
hold off;
xlabel('Day');
ylabel('Realized Beta');
title('Realized Beta and estimated confidence interval of DIS in January 2007');
xlim([min(days_DIS(1:d)),max(days_DIS(1:d))]);
ylim([min(CI_low_rbDIS(1:d))-0.1,max(CI_up_rbDIS(1:d))+0.1])
legend('Realized Beta','CI\_rblow','CI\_rbup');
datetick('x',7,'keeplimits');

%part e
n1_DIS=sum(CI_low_rbDIS <=1 & CI_up_rbDIS >=1);
n2_DIS=sum( CI_up_rbDIS < 1);
n3_DIS=sum( CI_low_rbDIS > 1);
