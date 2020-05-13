function [QIV] = QIV(diffusive_log_returns,N)
%diffusive_log_returns is a N*T matrix,N is the number of observation per day and T is the number of days for data
QIV=sum((N/3)*(diffusive_log_returns.^4));
end

