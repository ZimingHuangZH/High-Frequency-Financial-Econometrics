function [factor] = time_of_day_factor(log_returns)
%log_returns is a n*T matrix
B=sum(transpose(abs(log_returns(2:end,:).*log_returns(1:end-1,:))));
B=[B(1) B];
factor=transpose(B/mean(B));

end

