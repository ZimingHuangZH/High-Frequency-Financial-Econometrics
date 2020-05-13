function [c_log_returns,d_log_returns] = c_d_log_returns(log_returns,n,a)
%log_returns is a n*T matrix,n is the number of observation per day and T is the number of days for data
%a is the chosen number of sd.
addpath('functions');
bv=(pi/2)*sum(abs(log_returns(2:end,:).*log_returns(1:end-1,:)));
B=sum(transpose(abs(log_returns(2:end,:).*log_returns(1:end-1,:))));
B=[B(1) B];
F=transpose(B/mean(B));
cutoff=a*(1/n)^(0.49)*sqrt(F.*bv);
c_log_returns=log_returns.*(abs(log_returns)<=cutoff);
d_log_returns=log_returns.*(abs(log_returns)>cutoff);
end

