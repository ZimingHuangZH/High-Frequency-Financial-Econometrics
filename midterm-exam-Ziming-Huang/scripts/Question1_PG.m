%----Q1

addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));%#observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));
alpha=5;
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG-1,alpha);

%part A
%pick "yesterday" September 15,2008,so t(September 16,2008)=d+1
d=max(find(floor(rdates_PG)==datenum('20080915','yyyymmdd')))/77;%find yestoday's data

%part B
%yesterday's TV to estimate IV
lr_c_PG1=lr_c_PG(:,d);% get yestoday's market data
TV_PG1=truncated_var_day(lr_c_PG1); % calculate yestoday's TV
QIV_PG1=sum(((N_PG-1)/3)*(lr_c_PG1.^4));

%part C
%loss probability
pd = makedist('Normal','mu',0,'sigma',1);
p2_PG = 1-cdf(pd,0.02/sqrt(TV_PG1));
p4_PG = 1-cdf(pd,0.04/sqrt(TV_PG1));

%95% CI of loss probability

%CI of IV
c=-norminv(0.025);
TVl_PG1=TV_PG1-c*sqrt(2*QIV_PG1/N_PG);
TVu_PG1=TV_PG1+c*sqrt(2*QIV_PG1/N_PG);
%CI of probability by using IV's CI
%q=0.02
p2u_PG = 1-cdf(pd,0.02/sqrt(TVu_PG1));
p2l_PG = 1-cdf(pd,0.02/sqrt(TVl_PG1));
%q=0.04
p4u_PG = 1-cdf(pd,0.04/sqrt(TVu_PG1));
p4l_PG = 1-cdf(pd,0.04/sqrt(TVl_PG1));

%part D
%VaR
V=200;% million
Q1_PG=norminv(0.01)*V*sqrt(TV_PG1); %lr here is not percentage
Q5_PG=norminv(0.05)*V*sqrt(TV_PG1);

%CI of VaR

%delta method
g1TV_PG=norminv(0.01)*V*sqrt(TV_PG1);
g5TV_PG=norminv(0.05)*V*sqrt(TV_PG1);

c=-norminv(0.025);
gQ1u_PG=g1TV_PG+c*norminv(0.01)*V*sqrt(QIV_PG1/(2*(N_PG-1)*TV_PG1));
gQ1l_PG=g1TV_PG-c*norminv(0.01)*V*sqrt(QIV_PG1/(2*(N_PG-1)*TV_PG1));
gQ5u_PG=g5TV_PG+c*norminv(0.05)*V*sqrt(QIV_PG1/(2*(N_PG-1)*TV_PG1));
gQ5l_PG=g5TV_PG-c*norminv(0.05)*V*sqrt(QIV_PG1/(2*(N_PG-1)*TV_PG1));

%simplified method
Q1u_PG=norminv(0.01)*V*sqrt(TVu_PG1);
Q1l_PG=norminv(0.01)*V*sqrt(TVl_PG1);
Q5u_PG=norminv(0.05)*V*sqrt(TVu_PG1);
Q5l_PG=norminv(0.05)*V*sqrt(TVl_PG1);


