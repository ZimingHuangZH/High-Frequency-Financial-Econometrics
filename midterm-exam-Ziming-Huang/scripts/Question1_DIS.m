%----Q1

addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));%#observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));
alpha=5;
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS-1,alpha);

%part A
%pick "yesterday" September 15,2008,so t(September 16,2008)=d+1
d=max(find(floor(rdates_DIS)==datenum('20080915','yyyymmdd')))/77;%find yestoday's data

%part B
%yesterday's TV to estimate IV
lr_c_DIS1=lr_c_DIS(:,d);% get yestoday's market data
TV_DIS1=truncated_var_day(lr_c_DIS1); % calculate yestoday's TV
QIV_DIS1=sum(((N_DIS-1)/3)*(lr_c_DIS1.^4));

%part C
%loss probability
pd = makedist('Normal','mu',0,'sigma',1);
p2_DIS = 1-cdf(pd,0.02/sqrt(TV_DIS1));
p4_DIS = 1-cdf(pd,0.04/sqrt(TV_DIS1));

%95% CI of loss probability

%CI of IV
c=-norminv(0.025);
TVl_DIS1=TV_DIS1-c*sqrt(2*QIV_DIS1/N_DIS);
TVu_DIS1=TV_DIS1+c*sqrt(2*QIV_DIS1/N_DIS);
%CI of probability by using IV's CI
%q=0.02
p2u_DIS = 1-cdf(pd,0.02/sqrt(TVu_DIS1));
p2l_DIS = 1-cdf(pd,0.02/sqrt(TVl_DIS1));
%q=0.04
p4u_DIS = 1-cdf(pd,0.04/sqrt(TVu_DIS1));
p4l_DIS = 1-cdf(pd,0.04/sqrt(TVl_DIS1));

%part D
%VaR
V=200;% million
Q1_DIS=norminv(0.01)*V*sqrt(TV_DIS1); %lr here is not percentage
Q5_DIS=norminv(0.05)*V*sqrt(TV_DIS1);

%CI of VaR

%delta method
g1TV_DIS=norminv(0.01)*V*sqrt(TV_DIS1);
g5TV_DIS=norminv(0.05)*V*sqrt(TV_DIS1);

c=-norminv(0.025);
gQ1u_DIS=g1TV_DIS+c*norminv(0.01)*V*sqrt(QIV_DIS1/(2*(N_DIS-1)*TV_DIS1));
gQ1l_DIS=g1TV_DIS-c*norminv(0.01)*V*sqrt(QIV_DIS1/(2*(N_DIS-1)*TV_DIS1));
gQ5u_DIS=g5TV_DIS+c*norminv(0.05)*V*sqrt(QIV_DIS1/(2*(N_DIS-1)*TV_DIS1));
gQ5l_DIS=g5TV_DIS-c*norminv(0.05)*V*sqrt(QIV_DIS1/(2*(N_DIS-1)*TV_DIS1));

%simplified method
Q1u_DIS=norminv(0.01)*V*sqrt(TVu_DIS1);
Q1l_DIS=norminv(0.01)*V*sqrt(TVl_DIS1);
Q5u_DIS=norminv(0.05)*V*sqrt(TVu_DIS1);
Q5l_DIS=norminv(0.05)*V*sqrt(TVl_DIS1);


