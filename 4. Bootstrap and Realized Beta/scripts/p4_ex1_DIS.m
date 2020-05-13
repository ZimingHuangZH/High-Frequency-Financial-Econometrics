addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));

%!!!
%if you want to check each scripts, you have to set the repeat time for this script
%otherwise, the code won't run successfully

M=11;
n=N_DIS-1;
kn=(N_DIS-1)/M;
%repeat times
%r=10000;

%part a
a=4.5;
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS,a);

 
Y1={'20070101','20080101','20090101','20100101','20110101','20120101','20130101','20140101','20150101','20160101','20170101','20180101'};
numY_DIS=datenum(Y1,'yyyymmdd');
L=[rdates_DIS(:),lr_d_DIS(:)];
numJ_DIS=zeros(1,11);
for i=1:11
    numJ_DIS(i)=sum(L(:,1)<=numY_DIS(i+1) & L(:,2)~=0);
end
numJ_DIS=diff([0 numJ_DIS]); 
J_DIS=sum(numJ_DIS);
figure;
plot(numY_DIS(1:11),numJ_DIS);
xlabel('year');
ylabel('jump times');
xlim([min(numY_DIS(1:11)),max(numY_DIS(1:11))]);
title('Jump times of DIS from 2007 to 2017');
datetick('x','keeplimits');

%part b
TV_DIS=truncated_var_day(lr_c_DIS);

figure;
plot(days_DIS,TV_DIS);
xlabel('Day');
ylabel('TV');
title('TV of DIS');
xlim([min(days_DIS),max(days_DIS)]);
datetick('x','keeplimits');

%part c
stv_DIS=zeros(r,T_DIS);
parfor i=1:r
    newsample=bsample(lr_DIS,kn,n,T_DIS);
    stv_DIS(i,:)=sum(newsample.^2);
end


CI_low_DIS = quantile(stv_DIS, 0.025);
CI_up_DIS = quantile(stv_DIS, 0.975);

num_in_DIS_d=sum(CI_low_DIS <=TV_DIS & CI_up_DIS >=TV_DIS);
cover_rate_DIS_d=num_in_DIS_d/T_DIS;




figure;
plot(days_DIS(1:10),TV_DIS(1:10));
hold on;
plot(days_DIS(1:10),CI_low_DIS(1:10));
hold on;
plot(days_DIS(1:10),CI_up_DIS(1:10));
hold off;
xlabel('Day');
ylabel('TV');
title('TV and estimated confidence interval of DIS in the first 2 week of 2007');
xlim([min(days_DIS(1:10)),max(days_DIS(1:10))]);
legend('TV','CI\_low','CI\_up');
datetick('x','keeplimits');


%part e
annualTV_DIS=100*sqrt(252*TV_DIS);
%b=max(find(rdates_DIS(:)>=733045 & rdates_DIS(:)<733059+1)/(N_DIS-1));
astv_DIS=zeros(r,T_DIS);
parfor i=1:r
    newsample=bsample(lr_DIS,kn,n,T_DIS);
    astv_DIS(i,:)=100*sqrt(252*sum(newsample.^2));
end

annualCI_low_DIS = quantile(astv_DIS, 0.025);
annualCI_up_DIS = quantile(astv_DIS, 0.975);

num_in_DIS_a=sum(annualCI_low_DIS <=annualTV_DIS & annualCI_up_DIS >=annualTV_DIS);
cover_rate_DIS_a=num_in_DIS_a/T_DIS;

figure;
plot(days_DIS(1:10),annualTV_DIS(1:10));
hold on;
plot(days_DIS(1:10),annualCI_low_DIS(1:10));
hold on;
plot(days_DIS(1:10),annualCI_up_DIS(1:10));
hold off;
xlabel('Day');
ylabel('TV(\%)');
title('Annual TV and estimated confidence interval of DIS in the first 2 week of 2007(\%)');
legend('TV','CI\_low','CI\_up');
xlim([min(days_DIS(1:10)),max(days_DIS(1:10))]);
datetick('x','keeplimits');


