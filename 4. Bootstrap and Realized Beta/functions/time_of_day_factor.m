function [factor] = time_of_day_factor(log_returns)
B=sum(transpose(abs(log_returns(2:end,:).*log_returns(1:end-1,:))));
B=[B(1) B];
factor=transpose(B/mean(B));

end

