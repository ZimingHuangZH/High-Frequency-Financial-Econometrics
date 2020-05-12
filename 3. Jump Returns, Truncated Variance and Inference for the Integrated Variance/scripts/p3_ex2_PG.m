addpath('D:\Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG,Y,M,D,H,MN,S]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG,4);

%------ex2
days_PG=unique(floor(rdates_PG));
%part a
tv_PG=truncated_var_day(lr_c_PG);
figure;
plot(days_PG,100*sqrt(tv_PG(:)*252));
xlabel('year');
ylabel('TV(\%)');
xlim([min(days_PG),max(days_PG)]);
title('Annual TV of PG(\%)');
datetick('x','keeplimits');
%part b
rv_PG=realized_var_day(lr_PG);
figure;
plot1=plot(days_PG,100*sqrt(rv_PG(:)*252));
hold on;
plot2=plot(days_PG,100*sqrt(tv_PG(:)*252));
plot2.Color(4) = 0.8;
xlabel('year');
ylabel('TV and RV(\%)');
xlim([min(days_PG),max(days_PG)]);
legend('RV(\%)','TV(\%)');
title('Annual TV and RV of PG(\%)');
datetick('x','keeplimits');
hold off;
%part c 
% estimator of QIV
QIV_PG=QIV(lr_c_PG,N_PG)
figure;
plot(days_PG,100*sqrt(252*QIV_PG));
xlabel('year');
ylabel('QIV(\%)');
title('Annual QIV of PG(\%)');
xlim([min(days_PG),max(days_PG)]);
datetick('x','keeplimits');
%part d
%CI
c=-norminv(0.025);
CI_l_PG=tv_PG-c*sqrt(2*QIV_PG/N_PG);
CI_r_PG=tv_PG+c*sqrt(2*QIV_PG/N_PG);
figure;
plot(days_PG,tv_PG);
hold on;
plot(days_PG,CI_l_PG);
hold on;
plot(days_PG,CI_r_PG);
legend('TV','lower\_IV','upper\_IV');
xlim([min(days_PG),max(days_PG)]);
xlabel('year');
ylabel('TV and 95\% CI of IV');
title('TV and 95\%CI of IV of PG');
datetick('x','keeplimits');
hold off;
%part e
num1=datenum('20081001','yyyymmdd');
num2=datenum('20081031','yyyymmdd');
a=sum(rdates_PG(:)<num1)/77;
b=sum(rdates_PG(:)<=num2)/77;
CI_l_PG_1=CI_l_PG(a+1:b);
CI_r_PG_1=CI_r_PG(a+1:b);
tv_PG_1=tv_PG(a+1:b);

figure;
plot(days_PG(a+1:b),tv_PG_1);
hold on;
plot(days_PG(a+1:b),CI_l_PG_1);
hold on;
plot(days_PG(a+1:b),CI_r_PG_1);
legend('TV','lower\_IV','upper\_IV');
xlabel('date');
ylabel('TV and 95\% CI of IV');
title('TV and 95\% CI of IV in October 2008(PG)');
datetick('x',26,'keeplimits');
xlim([min(days_PG(a+1:b)),max(days_PG(a+1:b))]);
hold off;

%part h
annualtv_PG=100*sqrt(252*tv_PG);
annualCI_l_PG=annualtv_PG-c*sqrt(2*QIV_PG/N_PG)*100*sqrt(63).*tv_PG.^(-1/2);
annualCI_r_PG=annualtv_PG+c*sqrt(2*QIV_PG/N_PG)*100*sqrt(63).*tv_PG.^(-1/2);
figure;
plot(days_PG,annualtv_PG);
hold on;
plot(days_PG,annualCI_l_PG);
hold on;
plot(days_PG,annualCI_r_PG);
legend('TV','lower\_TV','upper\_TV');
xlim([min(days_PG),max(days_PG)]);
xlabel('year');
ylabel('annual TV and 95\% CI of annual IV(\%)');
title('annual TV and 95\% CI of annual IV(\%)(PG)');
datetick('x','keeplimits');
hold off;
%Focus on Octorber 2008
CI_l_PG_2=annualCI_l_PG(a+1:b);
CI_r_PG_2=annualCI_r_PG(a+1:b);
tv_PG_2=annualtv_PG(a+1:b);
figure;
plot(days_PG(a+1:b),tv_PG_2);
hold on;
plot(days_PG(a+1:b),CI_l_PG_2);
hold on;
plot(days_PG(a+1:b),CI_r_PG_2);
legend('TV','lower\_IV','upper\_IV');
xlabel('date');
ylabel('annual TV and 95\% CI of annual IV(\%)');
title('annual TV and 95\% CI of annual IV(\%) in October 2008(PG)');
datetick('x',26,'keeplimits');
xlim([min(days_PG(a+1:b)),max(days_PG(a+1:b))]);
hold off;
