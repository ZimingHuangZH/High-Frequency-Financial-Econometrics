addpath('D:\Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS,Y,M,D,H,MN,S]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS,4);

%------ex2
days_DIS=unique(floor(rdates_DIS));
%part a
tv_DIS=truncated_var_day(lr_c_DIS);
figure;
plot(days_DIS,100*sqrt(tv_DIS(:)*252));
xlabel('year');
ylabel('TV(\%)');
xlim([min(days_DIS),max(days_DIS)]);
title('Annual TV of DIS(\%)');
datetick('x','keeplimits');
%part b
rv_DIS=realized_var_day(lr_DIS);
figure;
plot1=plot(days_DIS,100*sqrt(rv_DIS(:)*252));
hold on;
plot2=plot(days_DIS,100*sqrt(tv_DIS(:)*252));
plot2.Color(4) = 0.8;
xlabel('year');
ylabel('TV and RV(\%)');
xlim([min(days_DIS),max(days_DIS)]);
legend('TV(\%)','RV(\%)');
title('Annual TV and RV of DIS(\%)');
datetick('x','keeplimits');
hold off;
%part c 
% estimator of QIV
QIV_DIS=QIV(lr_c_DIS,N_DIS)
figure;
plot(days_DIS,100*sqrt(252*QIV_DIS));
xlabel('year');
ylabel('QIV(\%)');
title('Annual QIV of DIS(\%)');
xlim([min(days_DIS),max(days_DIS)]);
datetick('x','keeplimits');
%part d
%CI
c=-norminv(0.025);
CI_l_DIS=tv_DIS-c*sqrt(2*QIV_DIS/N_DIS);
CI_r_DIS=tv_DIS+c*sqrt(2*QIV_DIS/N_DIS);
figure;
plot(days_DIS,tv_DIS);
hold on;
plot(days_DIS,CI_l_DIS);
hold on;
plot(days_DIS,CI_r_DIS);
legend('TV','lower\_IV','upper\_IV');
xlim([min(days_DIS),max(days_DIS)]);
xlabel('year');
ylabel('TV and 95\% CI of IV');
title('TV and 95\%CI of IV of DIS');
datetick('x','keeplimits');
hold off;
%part e
num1=datenum('20081001','yyyymmdd');
num2=datenum('20081031','yyyymmdd');
a=sum(rdates_DIS(:)<num1)/77;
b=sum(rdates_DIS(:)<=num2)/77;
CI_l_DIS_1=CI_l_DIS(a+1:b);
CI_r_DIS_1=CI_r_DIS(a+1:b);
tv_DIS_1=tv_DIS(a+1:b);

figure;
plot(days_DIS(a+1:b),tv_DIS_1);
hold on;
plot(days_DIS(a+1:b),CI_l_DIS_1);
hold on;
plot(days_DIS(a+1:b),CI_r_DIS_1);
legend('TV','lower\_IV','upper\_IV');
xlabel('date');
ylabel('TV and 95\% CI of IV');
title('TV and 95\% CI of IV in October 2008(DIS)');
datetick('x',26,'keeplimits');
xlim([min(days_DIS(a+1:b)),max(days_DIS(a+1:b))]);
hold off;

%part h
annualtv_DIS=100*sqrt(252*tv_DIS);
annualCI_l_DIS=annualtv_DIS-c*sqrt(2*QIV_DIS/N_DIS)*100*sqrt(63).*tv_DIS.^(-1/2);
annualCI_r_DIS=annualtv_DIS+c*sqrt(2*QIV_DIS/N_DIS)*100*sqrt(63).*tv_DIS.^(-1/2);
figure;
plot(days_DIS,annualtv_DIS);
hold on;
plot(days_DIS,annualCI_l_DIS);
hold on;
plot(days_DIS,annualCI_r_DIS);
legend('TV','lower\_TV','upper\_TV');
xlim([min(days_DIS),max(days_DIS)]);
xlabel('year');
ylabel('annual TV and 95\% CI of annual IV(\%)');
title('annual TV and 95\% CI of annual IV(\%)(DIS)');
datetick('x','keeplimits');
hold off;
% Focus on Octorber 2008
CI_l_DIS_2=annualCI_l_DIS(a+1:b);
CI_r_DIS_2=annualCI_r_DIS(a+1:b);
tv_DIS_2=annualtv_DIS(a+1:b);
figure;
plot(days_DIS(a+1:b),tv_DIS_2);
hold on;
plot(days_DIS(a+1:b),CI_l_DIS_2);
hold on;
plot(days_DIS(a+1:b),CI_r_DIS_2);
legend('TV','lower\_IV','upper\_IV');
xlabel('date');
ylabel('annual TV and 95\% CI of annual IV(\%)');
title('annual TV and 95\% CI of annual IV(\%) in October 2008(DIS)');
datetick('x',26,'keeplimits');
xlim([min(days_DIS(a+1:b)),max(days_DIS(a+1:b))]);
hold off;


