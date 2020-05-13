addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');


[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG,a);


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
n=N_PG-1;
kn=(N_PG-1)/M;
%(repeat time)
%r=10000;

%---part a
rbeta_PG=realized_beta(lr_c_PG, lr_c_SPY);

figure;
plot(days_PG,rbeta_PG);
xlabel('Day');
ylabel('Realized Beta');
title('Realized Beta over years for PG');
xlim([min(days_PG),max(days_PG)]);
datetick('x','keeplimits');

%part c
sbeta=zeros(r,T_PG);
parfor i=1:r
    [newsample1,newsample2]=bsample_2(lr_c_PG,lr_c_SPY,kn,n,T_PG);
    sbeta(i,:)=sum(newsample1.*newsample2)./sum(newsample2.^2);
end

CI_low_rbPG = quantile(sbeta, 0.025);
CI_up_rbPG = quantile(sbeta, 0.975);

%evaluate the estimated confidence interval
num_in_PG=sum(CI_low_rbPG <=rbeta_PG & CI_up_rbPG >=rbeta_PG);
cover_rate_PG=num_in_PG/T_PG;

figure;
plot(days_PG,rbeta_PG);
hold on;
plot(days_PG,CI_low_rbPG);
hold on;
plot(days_PG,CI_up_rbPG);
hold off;
xlabel('Day');
ylabel('Realized Beta');
title('Realized Beta and estimated confidence interval of PG');
xlim([min(days_PG),max(days_PG)]);
legend('Realized Beta','CI\_rblow','CI\_rbup');
datetick('x','keeplimits');

%part d(focus in a month)
d=21;
figure;
plot(days_PG(1:d),rbeta_PG(1:d));
hold on;
plot(days_PG(1:d),CI_low_rbPG(1:d));
hold on;
plot(days_PG(1:d),CI_up_rbPG(1:d));
hold off;
xlabel('Day');
ylabel('Realized Beta');
title('Realized Beta and estimated confidence interval of PG in January 2007');
xlim([min(days_PG(1:d)),max(days_PG(1:d))]);
ylim([min(CI_low_rbPG(1:d))-0.1,max(CI_up_rbPG(1:d))+0.1])
legend('Realized Beta','CI\_rblow','CI\_rbup');
datetick('x',7,'keeplimits');

%part e
n1_PG=sum(CI_low_rbPG <=1 & CI_up_rbPG >=1);
n2_PG=sum( CI_up_rbPG < 1);
n3_PG=sum( CI_low_rbPG > 1);




