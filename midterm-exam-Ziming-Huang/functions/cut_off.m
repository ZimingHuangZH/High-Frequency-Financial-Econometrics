function [outputArg1,outputArg2] = cut_off(log_retun,a,N,T)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
F=time_of_day_factor(log_retun);
BV=bipower_var_day(log_retun);
cut_off=[];
for T=1:T
    for i=1:N
       cut_off(i,T)=a*(1/N)^(0.49)*sqrt(F(i)*BV(T));
    end
end

end

