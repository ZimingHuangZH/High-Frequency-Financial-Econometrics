function [tv] = truncated_var_day(diffusive_log_returns)
addpath('functions')
tv=sum(diffusive_log_returns.^2);
end

