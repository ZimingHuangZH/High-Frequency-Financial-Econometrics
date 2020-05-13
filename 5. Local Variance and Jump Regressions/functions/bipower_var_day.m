function [bv] = bipower_var_day(log_returns)
%calculate the annual bipower variance percentage

bv=(pi/2)*sum(abs(log_returns(2:end,:).*log_returns(1:end-1,:)));
%bv=100*sqrt(252*bv);
%bv=bv(:)
end


