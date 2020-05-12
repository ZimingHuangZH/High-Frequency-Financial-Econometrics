% -----EXCERCIZE #3(JUMP DIFFUSION MODEL WITH CONSTENT COEFFICIENTS)------
% SET PARAMETERS
n=80;
T=1.25*252;
u=0.03872/100;
c=0.011^2;
x0=log(292.58);
sigma=0.011;
lamda=15/252;

% PART B(STIMULATE MODEL)
X1=GD_c(T,n,c,u,x0); % calculate value of Xt
J1=jump(lamda,T,n,sigma); % calculate value of Jt

t=0:1/n:T; % construct observation time series
X2_with_jump=X1+J1; %calculate log-price with jump
P2_with_jump=exp(X2_with_jump);%convert log-price to price
f3=figure('name','Time Series of Price with Jump(JUMP DIFFUSION MODEL WITH CONSTENT COEFFICIENTS)');
plot(t,P2_with_jump);% plot of time series price
xlabel('Time(day)');
ylabel('Price with jump');
xlim([0,T]);
%------------------------END OF EXCERCIZE #3------------------------------