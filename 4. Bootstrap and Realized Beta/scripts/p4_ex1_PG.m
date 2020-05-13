addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));


%!!!
%if you want to check each scripts, you have to set the repeat time for this script
%otherwise, the code won't run successfully
M=11;
n=N_PG-1;
kn=(N_PG-1)/M;
%repeat times
%r=10000;

%part a
a=4.5;
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG,a);

Y1={'20070101','20080101','20090101','20100101','20110101','20120101','20130101','20140101','20150101','20160101','20170101','20180101'};
numY_PG=datenum(Y1,'yyyymmdd');
L=[rdates_PG(:),lr_d_PG(:)];
numJ_PG=zeros(1,11);
for i=1:11
    numJ_PG(i)=sum(L(:,1)<=numY_PG(i+1) & L(:,2)~=0);
end
numJ_PG=diff([0 numJ_PG]); 
J_PG=sum(numJ_PG);
figure;
plot(numY_PG(1:11),numJ_PG);
xlabel('year');
ylabel('jump times');
xlim([min(numY_PG(1:11)),max(numY_PG(1:11))]);
title('Jump times of PG from 2007 to 2017');
datetick('x','keeplimits');

%part b
TV_PG=truncated_var_day(lr_c_PG);

figure;
plot(days_PG,TV_PG);
xlabel('Day');
ylabel('TV');
title('TV of PG');
xlim([min(days_PG),max(days_PG)]);
datetick('x','keeplimits');

%part c
stv=zeros(r,T_PG);
parfor i=1:r
    newsample=bsample(lr_PG,kn,n,T_PG);
    stv(i,:)=sum(newsample.^2);
end

CI_low_PG = quantile(stv, 0.025);
CI_up_PG = quantile(stv, 0.975);
%evaluate estimated CI
num_in_PG_d=sum(CI_low_PG <=TV_PG & CI_up_PG >=TV_PG);
cover_rate_PG_d=num_in_PG_d/T_PG;

figure;
plot(days_PG(1:10),TV_PG(1:10));
hold on;
plot(days_PG(1:10),CI_low_PG(1:10));
hold on;
plot(days_PG(1:10),CI_up_PG(1:10));
hold off;
xlabel('Day');
ylabel('TV');
title('TV and estimated confidence interval of PG in the first 2 week of 2007');
xlim([min(days_PG(1:10)),max(days_PG(1:10))]);
legend('TV','CI\_low','CI\_up');
datetick('x','keeplimits');

%part e
annualTV_PG=100*sqrt(252*TV_PG);
%b=max(find(rdates_PG(:)>=733045 & rdates_PG(:)<733059+1)/(N_PG-1));
atv=zeros(r,T_PG);
parfor i=1:r
     newsample=bsample(lr_PG,kn,n,T_PG);
    atv(i,:)=100*sqrt(252*sum(newsample.^2));
end

annualCI_low_PG = quantile(atv, 0.025);
annualCI_up_PG = quantile(atv, 0.975);
%evaluate estamated CI
num_in_PG_a=sum(annualCI_low_PG <=annualTV_PG & annualCI_up_PG >=annualTV_PG);
cover_rate_PG_a=num_in_PG_a/T_PG;

figure;
plot(days_PG(1:10),annualTV_PG(1:10));
hold on;
plot(days_PG(1:10),annualCI_low_PG(1:10));
hold on;
plot(days_PG(1:10),annualCI_up_PG(1:10));
hold off;
xlabel('Day');
ylabel('TV(\%)');
title('Annual TV and estimated confidence interval of PG in the first 2 week of 2007(\%)');
legend('TV','CI\_low','CI\_up');
xlim([min(days_PG(1:10)),max(days_PG(1:10))]);
datetick('x','keeplimits');