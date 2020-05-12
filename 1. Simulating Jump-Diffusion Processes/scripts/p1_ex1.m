% -----EXCERCIZE #1(GAUSSIAN DIFFUSION MODEL WITH CONSTENT COEFFICIENTS)--
% SET PARAMETERS
n=80;
T=1.25*252;
u=0.03872/100;
c=0.011^2;
x0=log(292.58);

% PART B(STIMULATE MODEL)
X1=GD_c(T,n,c,u,x0) % calculate value of Xt
P1=exp(X1); % convert log-price to price
t=0:1/n:T; % construct observation time series
f1=figure('name','Time Series of Prices(GAUSSIAN DIFFUSION MODEL WITH CONSTENT COEFFICIENTS)');
plot(t,P1);% plot time series of prices
xlabel('Time(day)');
ylabel('Price');
xlim([0,T]);
% ------------------------END OF EXCERCIZE #1------------------------------