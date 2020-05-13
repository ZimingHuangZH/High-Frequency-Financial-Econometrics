function [log_returns] = log_return_new(log_price,kn,s,e)
%the input data log_price is a N*T matrix
%N is the number of observation per day
%T is the length of observation
%kn is the frequency of data
%s is the first data to use withday
%e is the last data to use withday
log_returns=diff(log_price(s:kn:e,:));
end