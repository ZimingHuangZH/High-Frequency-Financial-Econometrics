function [c] = JD_sv_ct(ne,T,l,u_c,sigma_c,c0)
% simulate stochastic variance process {ct} in a Jump-diffusion model
% c is the array of ct between t vary from 0~T
% T is total observe time
% l is the correlation parameter
% ne is the number of observations in every unit of time
% sigma is the standard variance of {ct}
% u is the mean of {ct}
c=[];
c(1)=c0; % initial value of ct(at t=0)
delta_e=1/ne; % delta_e is the time gap between every observation
 for j=1:ne*T %observation number from 1 to ne*T
     r=normrnd(0,1); %construct random variable from standard normal distribution
     c(j+1)=max(c(j)+l*(u_c-c(j))*delta_e+sigma_c*sqrt(c(j)*delta_e)*r,u_c/2);  % calculate c(i+1) by iteration
 end
end


