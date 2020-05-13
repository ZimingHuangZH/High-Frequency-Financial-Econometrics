%2A
[X,Y]=simulation(var1,var2,var3,N,beta);
%2B
beta_hat=OLS(X,Y);
%3C
X1=zeros(N,r);
Y1=zeros(N,r);
beta_hat1=zeros(r,2);
for i=1:r
 [X1(:,i),Y1(:,i)]=simulation(var1,var2,var3,N,beta);
 beta_hat1(i,:)=OLS(X1(:,i),Y1(:,i));
end

figure;
histogram(beta_hat1(:,2));
xlabel('$\hat{\beta_0}$');
ylabel('Frequency');
title('Histogram figure of estameted $\beta_0$');
figure;
histogram(beta_hat1(:,1));
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