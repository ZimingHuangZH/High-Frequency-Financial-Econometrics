addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');

%EXERCISE 1
%PART F

% SET PARAMETERS
n=80;
T=1.25*252;
ne=n*20;
l=0.03;
u_c=0.011^2;
sigma_c=0.001;
c0=u_c;
x0=log(292.58);

%!!!
%if you want to check each scripts, you have to set the repeat time for this script
%otherwise, the code won't run successfully

%repeat times
%r=10000;
kn=n;
r=10;



%Produce Ct
Ct=JD_sv_ct(ne,T,l,u_c,sigma_c,c0);
%Compute Real IV
Ct1=reshape(Ct(2:end),ne,[]);
IVt=sum(Ct1*1/ne);

%Stimulate Xt and Compute RV
%produce high frequency Xt
Xt=JD_sv_xt(ne,T,Ct,x0);
%compute coaser frequency log-return 
Xt1=Xt(1:20:end);
lr=reshape(diff(Xt1),80,[]);
%compute RVt
RVt=realized_var_day(lr);

%Estimate the CI of IVt by asymptotic distribution
QIVt=QIV(lr,n);
c=-norminv(0.025);
CI_l_1=RVt-c*sqrt(2*QIVt/n);
CI_u_1=RVt+c*sqrt(2*QIVt/n);
% Evaluate 
num_in_1=sum(CI_l_1<=IVt & IVt<=CI_u_1);
cover_rate_1=num_in_1/T;

%draw asymptotic CI
figure;
plot((1:T),IVt);
hold on;
plot((1:T),CI_l_1);
hold on;
plot((1:T),CI_u_1);
xlabel('time(day)');
ylabel('IVt');
xlim([0,T]);
legend('IVt','CI\_lower\_asym','CI\_upper\_asym');

%Estimate the CI of IVt by bootstrap


%part c
sRV=zeros(r,T);
parfor i=1:r
    newsample=bsample(lr,kn,n,T);
    sRV(i,:)=sum(newsample.^2);
end

CI_l_2= quantile(sRV, 0.025);
CI_u_2 = quantile(sRV, 0.975);

% Evaluate 
num_in_2=sum(CI_l_2<=IVt & IVt<=CI_u_2);
cover_rate_2=num_in_2/T;

%draw bootstrap CI
figure;
plot((1:T),IVt);
hold on;
plot((1:T),CI_l_2);
hold on;
plot((1:T),CI_u_2);
xlabel('time(day)');
ylabel('IVt');
xlim([0,T]);
legend('IVt','CI\_lower\_bstrap','CI\_upper\_bstrap');

%draw two CI together
figure;
plot((1:T),IVt);
hold on;
plot((1:T),CI_l_1);
hold on;
plot((1:T),CI_u_1);
hold on;
plot((1:T),CI_l_2);
hold on;
plot((1:T),CI_u_2);
xlabel('time(day)');
ylabel('IVt');
xlim([0,T]);
legend('IVt','CI\_lower\_asym','CI\_upper\_asym','CI\_lower\_bstrap','CI\_upper\_bstrap');


