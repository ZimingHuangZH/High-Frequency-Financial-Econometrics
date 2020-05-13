function [x] =JD_sv_xt(ne,T,C,x0)
% simulate high-frequence log-price {xt} in a Jump-diffusion model with stochastic volatility
% x is the array of xt between t vary from 0~T
% x0 is the initial value of xt(at t=0)
% c is the array of ct between t vary from 0~T
% T is total observe time
% l is the correlation parameter
% ne is the number of observations in every unit of time
% sigma is the standard variance of {ct}
% u is the mean of {ct}
delta_e=1/ne;  % delta_e is the time gap between every observation
x=[];
x(1)=x0; % initial value of xt(at t=0)
 for i=1:ne*T %observation number from 1 to ne*T
    r=normrnd(0,1);%construct random variable from standard normal distribution
    x(i+1)=x(i)+sqrt(C(i)*delta_e)*r;  % calculate c(i+1) by iteration
 end  
end

