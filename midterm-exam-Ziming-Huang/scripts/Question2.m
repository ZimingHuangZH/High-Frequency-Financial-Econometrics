%Question 2

addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));%#observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));

[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));%#observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));

[dates_SPY,lp_SPY]=load_stock('SPY.csv','m');
N_SPY=sum(floor(dates_SPY(1,1))==floor(dates_SPY(:,1)));%#observations per day
T_SPY=size(dates_SPY,1)/N_SPY;
[rdates_SPY,lr_SPY]=log_return([dates_SPY lp_SPY],N_SPY,1);
days_SPY=unique(floor(rdates_SPY));

alpha=5;
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG-1,alpha);
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS-1,alpha);
[lr_c_SPY,lr_d_SPY]=c_d_log_returns(lr_SPY,N_SPY-1,alpha);


% long asset is PG and short asset is DIS

%part A
%summary long-short continuous returns
lr_p=lr_PG-lr_DIS;%return of long-short portfolio
[lr_c_p,lr_d_p]=c_d_log_returns(lr_p,N_PG-1,alpha);
[m_1,mi_1,ma_1,q1_1,q2_1]=summary(lr_c_p(:));

%part B
% realized beta
rbeta=realized_beta(lr_c_p,lr_c_SPY);
[m_2,mi_2,ma_2,q1_2,q2_2]=summary(rbeta);

%part C
%compute CI of rbeta
kn=11;
n=N_PG-1;
r=1000;

sbeta=zeros(r,T_PG);
parfor i=1:r
    [newsample1,newsample2]=bsample_2(lr_c_p,lr_c_SPY,kn,n,T_PG);
    sbeta(i,:)=sum(newsample1.*newsample2)./sum(newsample2.^2);
end
%CI of rbeta
CI_low_rbp = quantile(sbeta, 0.025);
CI_up_rbp = quantile(sbeta, 0.975);

%plot long-short rbeta and its CI
figure;
plot(days_PG,rbeta);
hold on;
plot(days_PG,CI_low_rbp);
hold on;
plot(days_PG,CI_up_rbp);
legend('Realized Beta','lower\_rbeta','upper\_rbeta');
xlabel('date');
ylabel('Rbeta and 95\% CI');
title('Rbeta of long-short portfolio and 95\% CI from 2007 to 2017');
datetick('x','keeplimits');
xlim([min(days_PG),max(days_PG)]);
hold off;

%part D
num1=datenum('20081001','yyyymmdd');
num2=datenum('20081031','yyyymmdd');
a=sum(rdates_PG(:)<num1)/77;
b=sum(rdates_PG(:)<=num2)/77;
CI_low_rbp_1=CI_low_rbp(a+1:b);
CI_up_rbp_1=CI_up_rbp(a+1:b);
rbeta_1=rbeta(a+1:b);

%plot rbeta and CI in October 2008 
figure;
plot(days_PG(a+1:b),rbeta_1);
hold on;
plot(days_PG(a+1:b),CI_low_rbp_1);
hold on;
plot(days_PG(a+1:b),CI_up_rbp_1);
legend('Realized Beta','lower\_rbeta','upper\_rbeta');
xlabel('date');
ylabel('Rbeta and 95\% CI');
title('Rbeta of long-short portfolio and 95\% CI in October 2008');
datetick('x',26,'keeplimits');
xlim([min(days_PG(a+1:b)),max(days_PG(a+1:b))]);
hold off;


%part E
%formal evaulation
%construct confidence interval for 0
%evaluate market neutral
n1=sum(CI_low_rbp <=0 & CI_up_rbp >=0);% CI contain 0
n2=sum( CI_up_rbp < 0);%CI lower 0
n3=sum( CI_low_rbp > 0);%CI upper 0








