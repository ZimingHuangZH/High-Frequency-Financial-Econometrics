function [QIV] = QIV(lr_c,n)
%diffusive_log_returns is a N*T matrix,N is the number of observation per day and T is the number of days for data
QIV=sum((n/3)*(lr_c.^4));
end

