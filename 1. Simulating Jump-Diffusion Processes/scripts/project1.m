% -----EXCERCIZE #1(GAUSSIAN DIFFUSION MODEL WITH CONSTENT COEFFICIENTS)--
% SET PARAMETERS
n=80;
T=1.25*252;
u=0.03872/100;
c=0.011^2;
x0=log(292.58)

% PART B(STIMULATE MODEL)
X1=GD_c(T,n,c,u,x0) % calculate value of Xt
P1=exp(X1); % convert log-price to price
t=0:1/n:T; % construct observation time series
figure(1);
plot(t,P1);% plot time series of prices
xlabel('Time');
ylabel('Price');
% ------------------------END OF EXCERCIZE #1------------------------------


% ---------------EXCERSIZE #2(COMPOUND POISSON PROCESS)-------------------
% SET PARAMETERS
n=80;
T=1.25*252;
sigma=0.011;
lamda=15/252;

% PART B(STIMULATE MODEL)
J1=jump(lamda,T,n,sigma); % calculate value of Jt
t=0:1/n:T; % construct observation time series
plot(t,J1);% plot of the simulated compound Poisson process
xlabel('Time');
ylabel('Jump of log-price');
%------------------------END OF EXCERCIZE #2------------------------------



% -----EXCERCIZE #3(JUMP DIFFUSION MODEL WITH CONSTENT COEFFICIENTS)------
% PART B(STIMULATE MODEL)
t=0:1/n:T; % construct observation time series
X2_with_jump=X1+J1 %calculate log-price with jump
P2_with_jump=exp(X2_with_jump);%convert log-price to price
plot(t,P2_with_jump);% plot of time series price
xlabel('Time');
ylabel('Price with jump');
xlim([0,T]);
%------------------------END OF EXCERCIZE #3------------------------------



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
plot(te,Ct);% plot of time series Ct
xlabel('Time');
ylabel('Ct');
xlim([0,T]);
% PART C(STIMULATE Xt MODEL)
X3=JD_sv_xt(ne,T,Ct,x0);%calculate Xt
P3=exp(X3); %convert log-price to price
plot(te,P3);% plot of time series price
xlabel('Time');
ylabel('Price');
xlim([0,T]);
% PART D(STIMULATE LOG-RETURN)
R1=diff(X3);%calculate log_return
D1=[0,R1];
plot(te,D1);% plot of time series log_return
xlabel('Time');
ylabel('Lor-return of price(high frequency)');
xlim([0,T]);
% PART E(STIMULATE Xt AT A COARSER FREQUENCY)
t=0:1/n:T; % construct coarser observation time series
X4=X3([1:20:end]);% choose coarser frequency observation
R2=diff(X4);%calculate log_return
D2=[0,R2];
plot(t,D2);% plot of time series log_return of coarser frequency observations
xlabel('Time');
ylabel('Lor-return of price(coarser frequency)');
xlim([0,T]);







