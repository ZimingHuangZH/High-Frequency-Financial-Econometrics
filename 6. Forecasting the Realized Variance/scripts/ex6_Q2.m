addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');


%2A
var1=25.2;
var2=0.5;% noise in Y
var3=0; % noise in X
beta=1;
N=100;
[X,Y]=simulation(var1,var2,var3,N,beta);
%2B
beta_hat=OLS(X,Y);
%3C
r=1000;
X1=zeros(N,r);
Y1=zeros(N,r);
beta_hat1=zeros(r,2);
for i=1:r
 [X1(:,i),Y1(:,i)]=simulation(var1,var2,var3,N,beta);
 beta_hat1(i,:)=OLS(X1(:,i),Y1(:,i));
end

figure;
histogram(beta_hat1(:,2),20);
xlabel('$\hat{\beta_0}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_0$');
figure;
histogram(beta_hat1(:,1),20);
xlabel('$\hat{\beta_1}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_1$');

%2D
[f_beta0,x_beta0]=ksdensity(beta_hat1(:,2),'Kernel','epanechnikov','Bandwidth',0.01);
figure;
plot(x_beta0,f_beta0);
xlabel('$\hat{\beta_0}$');
grid on;
title('Estimated p.d.f of $\beta_0$');
 
[f_beta1,x_beta1]=ksdensity(beta_hat1(:,1),'Kernel','epanechnikov','Bandwidth',0.002);
figure;
plot(x_beta1,f_beta1);
xlabel('$\hat{\beta_1}$');
grid on;
title('Estimated p.d.f of $\beta_1$');
 

%2E
%repeat A
var1=25.2;
var2=0.5;
var3=0.3*var1;
beta=1;
N=100;
[X_hat,Y_hat]=simulation(var1,var2,var3,N,beta);
%repeat B
%estimate beta_hat
beta_hat_1=OLS(X_hat,Y_hat);
%repeat C
%estimate different beta_hat
r=1000;
X2=zeros(N,r);
Y2=zeros(N,r);
beta_hat2=zeros(r,2);
for i=1:r
 [X2(:,i),Y2(:,i)]=simulation(var1,var2,var3,N,beta);
 beta_hat2(i,:)=OLS(X2(:,i),Y2(:,i));
end


figure;
histogram(beta_hat2(:,2));
xlabel('$\hat{\beta_0}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_0$');
figure;
histogram(beta_hat2(:,1));
xlabel('$\hat{\beta_1}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_1$');

%repeat C
%estimate distribution of beta_hat

[f_beta0,x_beta0]=ksdensity(beta_hat2(:,2),'Kernel','epanechnikov','Bandwidth',0.01);
figure;
plot(x_beta0,f_beta0);
xlabel('$\hat{\beta_0}$');
grid on;
title('Estimated p.d.f of $\beta_0$');
 
[f_beta1,x_beta1]=ksdensity(beta_hat2(:,1),'Kernel','epanechnikov','Bandwidth',0.002);
figure;
plot(x_beta1,f_beta1);
xlabel('$\hat{\beta_1}$');
grid on;
title('Estimated p.d.f of $\beta_1$');

%2F
%repeat A
var1=25.2;
var2=0.5;
var3=0.5*var1;
beta=1;
N=100;
[X_hat,Y_hat]=simulation(var1,var2,var3,N,beta);
%repeat B
%estimate beta_hat
beta_hat_3=OLS(X_hat,Y_hat);
%repeat C
%estimate different beta_hat
r=1000;
X2=zeros(N,r);
Y2=zeros(N,r);
beta_hat4=zeros(r,2);
for i=1:r
 [X2(:,i),Y2(:,i)]=simulation(var1,var2,var3,N,beta);
 beta_hat4(i,:)=OLS(X2(:,i),Y2(:,i));
end


figure;
histogram(beta_hat4(:,2));
xlabel('$\hat{\beta_0}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_0$');
figure;
histogram(beta_hat4(:,1));
xlabel('$\hat{\beta_1}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_1$');

%repeat C
%estimate distribution of beta_hat

[f_beta0,x_beta0]=ksdensity(beta_hat4(:,2),'Kernel','epanechnikov','Bandwidth',0.01);
figure;
plot(x_beta0,f_beta0);
xlabel('$\hat{\beta_0}$');
grid on;
title('Estimated p.d.f of $\beta_0$');
 
[f_beta1,x_beta1]=ksdensity(beta_hat4(:,1),'Kernel','epanechnikov','Bandwidth',0.002);
figure;
plot(x_beta1,f_beta1);
xlabel('$\hat{\beta_1}$');
grid on;
title('Estimated p.d.f of $\beta_1$');

 
 
 
 
 
 
