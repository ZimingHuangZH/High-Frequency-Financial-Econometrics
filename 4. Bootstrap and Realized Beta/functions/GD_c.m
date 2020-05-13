function [x] = GD_c(T,n,c,u,x0)
% simulate a Gaussian diffusion model with CONSTANT coefficient
% T is total observe time
% x is the array of log-price of asset between time 0~T
% x0 is the initial value of xt(at t=0)
% n is the number of observations in every unit of time
% c is the standard variance of log-price
% u is the mean of asset's log-price
     x=[];
     x(1)=x0; % initial value of x(at t=0)
     delta_t=1/n; % delta_t is the time gap between every observation
     for i=1:T*n % observation number from 1 to T*n
         z=normrnd(0,1); % construct random variable from standard normal distribution
         x(i+1)=x(i)+u*delta_t+sqrt(c*delta_t)*z; % calculate x(i+1) by iteration
     end            
end
   
