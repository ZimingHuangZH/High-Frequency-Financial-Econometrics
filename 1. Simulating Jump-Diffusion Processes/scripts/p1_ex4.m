% ------EXCERSIZE #4(JUMP DIFFUSION MODEL WITH STOCHASTIC VOLATILITY)-----
% SET PARAMETERS
n=80;
T=1.25*252;
ne=n*20;
l=0.03;
u_c=0.011^2;
sigma_c=0.001;
c0=u_c;
x0=log(292.58);

% PART B(STIMULATE Ct MODEL)
Ct=JD_sv_ct(ne,T,l,u_c,sigma_c,c0);%calculate Ct
te=0:1/ne:T; % construct observation time series
f4_b=figure('name','Stimulation of Annual Ct');
plot(te,Ct*sqrt(252*ne)*100);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('Ct(\%)');
xlim([0,T]);

% PART C(STIMULATE Xt MODEL)
X3=JD_sv_xt(ne,T,Ct,x0);%calculate Xt
P3=exp(X3); %convert log-price to price
f4_c=figure('name','Stimulation of Price Xt');
plot(te,P3);% plot of time series price
xlabel('Time(day)');
ylabel('Price');
xlim([0,T]);

% PART D(STIMULATE LOG-RETURN)
R1=diff(X3);%calculate log_return
D1=[0,R1];
f4_d=figure('name','Time Series Log_return With High Frequence Sample');
plot(te,D1*100);% plot of time series percentage log_return
xlabel('Time(day)');
ylabel('Price Log-return (high frequency)(\%)');
xlim([0,T]);

% PART E(STIMULATE Xt AT A COARSER FREQUENCY)
t=0:1/n:T; % construct coarser observation time series
X4=X3(1:20:end);% choose coarser frequency observation
R2=diff(X4);%calculate log_return
D2=[0,R2];
f4_e=figure('name','Time Series Log_return  of Coarser Frequency Sample');
plot(t,D2*100);% plot of time series annual log_return of coarser frequency observations
xlabel('Time(day)');
ylabel('Price Log-return (coarser frequency)(\%)');
xlim([0,T]);

% PART F(INCREASE THE RATE OF CONVERGENCE)
% increase the rate convergence from 0.03 to 0.1
l2=0.1;
Ct_2=JD_sv_ct(ne,T,l2,u_c,sigma_c,c0);%calculate Ct
te=0:1/ne:T; % construct observation time series
figure('name','Stimulation of Annual Ct(with rate of convergence = 0.1');
plot(te,Ct_2*sqrt(252*ne)*100);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('Ct(\%)');
xlim([0,T]);
% increase the rate convergence from 0.03 to 0.5
l3=0.5;
Ct_3=JD_sv_ct(ne,T,l3,u_c,sigma_c,c0);%calculate Ct
te=0:1/ne:T; % construct observation time series
figure('name','Stimulation of Annual Ct(with rate of convergence = 0.5');
plot(te,Ct_3*sqrt(252*ne)*100);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('Ct(\%)');
xlim([0,T]);


% PART G(INCREASE THE RATE OF CONVERGENCE)
% increase the volatility of stochastic volatility from 0.001 to 0.005
sigma_c1=0.005;
Ct_4=JD_sv_ct(ne,T,l,u_c,sigma_c1,c0);%calculate Ct
te=0:1/ne:T; % construct observation time series
figure('name','Stimulation of Annual Ct(with volatility = 0.005');
plot(te,Ct_4*sqrt(252*ne)*100);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('Ct(\%)');
xlim([0,T]);
% increase the rate convergence from 0.03 to 0.5
sigma_c2=0.01;
Ct_5=JD_sv_ct(ne,T,l,u_c,sigma_c2,c0);%calculate Ct
te=0:1/ne:T; % construct observation time series
figure('name','Stimulation of Annual Ct(with rate of convergence = 0.01');
plot(te,Ct_5*sqrt(252*ne)*100);% plot of time series Ct(annual percentage)
xlabel('Time(day)');
ylabel('Ct(\%)');
xlim([0,T]);

