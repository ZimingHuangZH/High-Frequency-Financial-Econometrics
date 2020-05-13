function [rbeta] = realized_beta(cr1,cr0)
%cr1 is a (N-1)*T matrix of diffusive returns of individual stock, where N is the number of observation per day and T is the number of days for our data
%cr0 is a (N-1)*T matrix of diffusive returns of market index, where N is the number of observation per day and T is the number of days for our data
rcov=sum(cr1.*cr0);
iv=truncated_var_day(cr0);
rbeta=rcov./iv;
end

