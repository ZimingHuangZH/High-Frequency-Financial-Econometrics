function [c_log_returns,d_log_returns] = c_d_log_returns(log_returns,N,a)
%log_returns is a N*T matrix,N is the number of observation per day and T is the number of days for data
%a is the chosen number of sd.
addpath('functions');
bv=bipower_var_day(log_returns);
F=time_of_day_factor(log_returns);
cutoff=a*(1/N)^(0.49)*sqrt(F.*bv);
c_log_returns=log_returns.*(abs(log_returns)<=cutoff);
d_log_returns=log_returns.*(abs(log_returns)>=cutoff);
end

