addpath('D:\Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG,Y,M,D,H,MN,S]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);


%-----ex1
%part a
F_PG=time_of_day_factor(lr_PG);
figure;
plot(rdates_PG(:,1),F_PG);
xlabel('Time');
ylabel('Day Factor');
xlim([min(rdates_PG(:,1)),max(rdates_PG(:,1))]);
title('The time of day factor of PG');
datetick('x',15,'keeplimits');

%part c
a=4;
bv_PG=bipower_var_day(lr_PG);
cutoff_PG=a*(1/N_PG)^(0.49)*sqrt(F_PG.*bv_PG);
lr_c_PG=lr_PG.*(abs(lr_PG)<=cutoff_PG);
lr_d_PG=lr_PG.*(abs(lr_PG)>=cutoff_PG);
k=sum((lr_c_PG(:)+lr_d_PG(:)==lr_PG(:))); %verify whether the continuous returns + jump returns=total returns

%plot diffusion return
figure;
plot(rdates_PG(:),lr_c_PG(:)*100);
xlabel('time');
ylabel('diffusive return(\%)');
xlim([min(rdates_PG(:)),max(rdates_PG(:))]);
title('The diffusive return of PG(\%)');
datetick('x','keeplimits');
%plot jump return
figure;
plot(rdates_PG(:),lr_d_PG(:)*100);
xlabel('time');
ylabel('jump return(\%)');
xlim([min(rdates_PG(:)),max(rdates_PG(:))]);
title('The jump return of PG(\%)');
datetick('x','keeplimits');


%part d
Y1={'20070101','20080101','20090101','20100101','20110101','20120101','20130101','20140101','20150101','20160101','20170101','20180101'};
numY_PG=datenum(Y1,'yyyymmdd');
M=[rdates_PG(:),lr_d_PG(:)];
numJ_PG=[];
for i=1:11
    numJ_PG(i)=sum(M(:,1)<=numY_PG(i+1) & M(:,2)~=0);
end
numJ_PG=diff([0 numJ_PG]);  
figure;
plot(numY_PG(1:11),numJ_PG);
xlabel('year');
ylabel('jump times');
xlim([min(numY_PG(1:11)),max(numY_PG(1:11))]);
title('Jump times of PG from 2007 to 2017');
datetick('x','keeplimits');

%part e
figure;
histogram(lr_c_PG(:),1000);
xlabel('Diffusive returns');
ylabel('Frequency');
title('Histogram figure of PG diffusive returns');
figure;
histogram(nonzeros(lr_d_PG),100);
xlabel('Discrete returns');
ylabel('Frequency');
title('Histogram figure of discrete returns of PG');

%part g
%diffusion returns
[f_rc_PG,x_rc_PG]=ksdensity(lr_c_PG(:),'Kernel','epanechnikov','Bandwidth',0.001);
figure;
plot(x_rc_PG,f_rc_PG);
xlabel('Diffusive returns');
title('Estimated p.d.f of diffusive returns of PG');
%jump returns(delete zero returns)
[f_rd_PG,x_rd_PG]=ksdensity(nonzeros(lr_d_PG(:)),'Kernel','epanechnikov','Bandwidth',0.0006);
figure;
plot(x_rd_PG,f_rd_PG);
xlabel('Discrete returns');
title('Estimated p.d.f of discrete returns of PG');
%part h
pJ_PG=sum(lr_d_PG(:)>0);
nJ_PG=sum(lr_d_PG(:)<0);






