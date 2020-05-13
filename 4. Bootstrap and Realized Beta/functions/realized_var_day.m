function [rv] = realized_var_day(log_returns)
%calculate the annual realized variance percentage
rv=sum(log_returns.^2);

%rv=100*sqrt(252*rv);
%rv=rv(:);
end

