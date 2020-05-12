% ------EXCERSIZE #3(Monte Carlo Simulation)-----
% SET PARAMETERS
n=80;
T=1.25*252;
ne=n*20;
l=0.03;
u_c=0.011^2;
sigma_c=0.001;
c0=u_c;
x0=log(292.58);

%Part B(Produce Ct)
Ct=JD_sv_ct(ne,T,l,u_c,sigma_c,c0);%calculate Ct
te=0:1/ne:T; % construct observation time series
figure;
plot(te,Ct);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('C(t,i)');
title('Stimulation of  C(t,i)');
xlim([0,T]);

%Part C(Compute Real IV)
Ct1=reshape(Ct(2:end),ne,[]);
IVt=sum(Ct1*1/ne);
figure;
plot(1:T,IVt);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('IVt');
title('Stimulation of IVt');
xlim([1,T]);

%Part D(Stimulate Xt and Compute RV)
%produce high frequency Xt
Xt=JD_sv_xt(ne,T,Ct,x0);
%compute coaser frequency log-return 
Xt1=Xt(1:20:end);
lr=reshape(diff(Xt1),80,[]);
%compute RVt
RVt=realized_var_day(lr);
%plot IVt and RVt
figure;
plot(1:T,IVt);% plot of time series Ct(annual percentage)
hold on;
plot(1:T,RVt);
xlabel('Time(day)');
ylabel('IVt and RVt');
legend('IVt','RVt');
title('IVt and RVt');
xlim([1,T]);



%Part E(Estimate the Ci of IVt by RVt)
QIVt=QIV(lr,n);
c=-norminv(0.025);
CI_l=RVt-c*sqrt(2*QIVt/n);
CI_r=RVt+c*sqrt(2*QIVt/n);
figure;
plot(1:T,IVt);
hold on;
plot(1:T,CI_l);
hold on;
plot(1:T,CI_r);
legend('IV','lower\_IV','upper\_IV');
xlim([1,T]);
xlabel('time(day)');
ylabel('IV and 95\% CI of IV(estimated by RVt');
title('IV and 95\%CI of IV');
hold off;

% Part F(Evaluate RVt)
num_in=sum(CI_l<=IVt & IVt<=CI_r);
cover_rate=num_in/T;


%Part G(Stimulate Xt(with jump) and Compute RV)
% SET PARAMETERS
sigma_jump=30*sqrt(u_c/n);
lamda=20/252;

Jt=jump1(lamda,T,n,sigma_jump); % calculate value of Jt
XJt=Xt1+Jt;
PJt=exp(XJt);
t=0:1/n:T;
figure;
plot(t,PJt);% plot of time series price
xlabel('Time(day)');
ylabel('Price with jump(\$)');
title('Stimulation of Price Xt with Jump(\$)');
xlim([0,T]);


%Part H(Compute RV and CI of IV)
lr_j=reshape(diff(XJt),80,[]);
%compute RVt and
RVt_j=realized_var_day(lr_j);
%compute QIV and TV
[lr_c,lr_d]=c_d_log_returns(lr_j,n,4);
QIVt_j=QIV(lr_c,n);
TVt_j=truncated_var_day(lr_c);

%compute CI
annualIVt=100*sqrt(IVt*252);
annualRVt_j=100*sqrt(RVt_j*252);
annualCI_l_j=annualRVt_j-c*sqrt(2*QIVt_j/n)*100.*sqrt(63./TVt_j);
annualCI_r_j=annualRVt_j+c*sqrt(2*QIVt_j/n)*100.*sqrt(63./TVt_j);
figure;
plot(1:T,annualIVt);
hold on;
plot(1:T,annualCI_l_j);
hold on;
plot(1:T,annualCI_r_j);
legend('IV','lower\_IV','upper\_IV');
xlim([1,T]);
xlabel('time(day)');
ylabel('annual IV and 95\% CI of annual IV(\%)');
title('annual IV and 95\% CI of annual IV(\%)');
hold off;
% Part F(Evaluate RVt)
num_in_j=sum(annualCI_l_j<=annualIVt & annualIVt<=annualCI_r_j);
cover_rate_j=num_in_j/T;

%part I
% SET PARAMETERS
lamda2=1;

Jt2=jump1(lamda2,T,n,sigma_jump); % calculate value of Jt
XJt2=Xt1+Jt2;
PJt2=exp(XJt2);



%Compute RV and CI of IV
lr_j2=reshape(diff(XJt2),80,[]);
%compute RVt
RVt_j2=realized_var_day(lr_j2);
%compute QIV and TV
[lr_c2,lr_d2]=c_d_log_returns(lr_j2,n,4);
QIVt_j2=QIV(lr_c2,n);
TVt_j2=truncated_var_day(lr_c2);


%compute CI
annualIVt2=100*sqrt(IVt*252);
annualRVt_j2=100*sqrt(RVt_j2*252);
annualCI_l_j2=annualRVt_j2-c*sqrt(2*QIVt_j2/n)*100*sqrt(63).*TVt_j2.^(-1/2);
annualCI_r_j2=annualRVt_j2+c*sqrt(2*QIVt_j2/n)*100*sqrt(63).*TVt_j2.^(-1/2);
figure;
plot(1:T,annualIVt);
hold on;
plot(1:T,annualCI_l_j2);
hold on;
plot(1:T,annualCI_r_j2);
legend('IV','lower\_IV','upper\_IV');
xlim([1,T]);
xlabel('time(day)');
ylabel('annual IV and 95\% CI of annual IV(\%)');
title('annual IV and 95\% CI of annual IV(\%)');
hold off;
% Part F(Evaluate RVt)
num_in_j2=sum(annualCI_l_j2<=annualIVt & annualIVt<=annualCI_r_j2);
cover_rate_j2=num_in_j2/T;


