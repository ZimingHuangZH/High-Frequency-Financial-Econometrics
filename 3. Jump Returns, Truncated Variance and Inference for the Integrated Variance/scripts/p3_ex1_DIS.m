addpath('D:\Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS,Y,M,D,H,MN,S]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);


%-----ex1
%part a
F_DIS=time_of_day_factor(lr_DIS);
figure;
plot(rdates_DIS(:,1),F_DIS);
xlabel('Time');
ylabel('Day Factor');
xlim([min(rdates_DIS(:,1)),max(rdates_DIS(:,1))]);
title('The time of day factor of DIS');
datetick('x',15,'keeplimits');

%part c
a=4;
bv_DIS=bipower_var_day(lr_DIS);
cutoff_DIS=a*(1/N_DIS)^(0.49)*sqrt(F_DIS.*bv_DIS);
lr_c_DIS=lr_DIS.*(abs(lr_DIS)<=cutoff_DIS);
lr_d_DIS=lr_DIS.*(abs(lr_DIS)>=cutoff_DIS);
k=sum((lr_c_DIS(:)+lr_d_DIS(:)==lr_DIS(:))); %verify whether the continuous returns + jump returns=total returns

%plot diffusion return
figure;
plot(rdates_DIS(:),lr_c_DIS(:)*100);
xlabel('time');
ylabel('diffusive return(\%)');
xlim([min(rdates_DIS(:)),max(rdates_DIS(:))]);
title('The diffusive return of DIS(\%)');
datetick('x','keeplimits');
%plot jump return
figure;
plot(rdates_DIS(:),lr_d_DIS(:)*100);
xlabel('time');
ylabel('jump return(\%)');
xlim([min(rdates_DIS(:)),max(rdates_DIS(:))]);
title('The jump return of DIS(\%)');
datetick('x','keeplimits');


%part d
Y1={'20070101','20080101','20090101','20100101','20110101','20120101','20130101','20140101','20150101','20160101','20170101','20180101'};
numY_DIS=datenum(Y1,'yyyymmdd');
M=[rdates_DIS(:),lr_d_DIS(:)];
numJ_DIS=[];
for i=1:11
    numJ_DIS(i)=sum(M(:,1)<=numY_DIS(i+1) & M(:,2)~=0);
end
numJ_DIS=diff([0 numJ_DIS]);  
figure;
plot(numY_DIS(1:11),numJ_DIS);
xlabel('year');
ylabel('jump times');
xlim([min(numY_DIS(1:11)),max(numY_DIS(1:11))]);
title('Jump times of DIS from 2007 to 2017');
datetick('x','keeplimits');

%part e
figure;
histogram(lr_c_DIS(:),1000);
xlabel('Diffusive returns');
ylabel('Frequency');
title('Histogram figure of DIS diffusive returns');
figure;
histogram(nonzeros(lr_d_DIS),100);
xlabel('Discrete returns');
ylabel('Frequency');
title('Histogram figure of discrete returns of DIS');

%part g
%diffusion returns
[f_rc_DIS,x_rc_DIS]=ksdensity(lr_c_DIS(:),'Kernel','epanechnikov','Bandwidth',0.001);
figure;
plot(x_rc_DIS,f_rc_DIS);
xlabel('Diffusive returns');
title('Estimated p.d.f of diffusive returns of DIS');
%jump returns(delete zero returns)
[f_rd_DIS,x_rd_DIS]=ksdensity(nonzeros(lr_d_DIS(:)),'Kernel','epanechnikov','Bandwidth',0.0006);
figure;
plot(x_rd_DIS,f_rd_DIS);
xlabel('Discrete returns');
title('Estimated p.d.f of discrete returns of DIS');
%part h
pJ_DIS=sum(lr_d_DIS(:)>0);
nJ_DIS=sum(lr_d_DIS(:)<0);






