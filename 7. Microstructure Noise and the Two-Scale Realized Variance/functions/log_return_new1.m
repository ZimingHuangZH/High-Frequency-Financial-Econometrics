function [return_dates,log_returns] = log_return_new(data,N,kn,s,e)
%data is a 2 column matrix where the first column is date, 
%the second column is the log-price 
%data=[dates, log-price]
%N is the number of observations every day
%kn is the number of steps between observations
%output are return_dates and log_return: they are group by day and shown in matrix 
%s is the first data using withday
%e is the last data using withday
%indic=s:kn:e;
%return_dates=reshape(data(:,1),N,[]); %reshape by day group
%return_dates=return_dates(s:kn:e,:); %pick up useful observations
%return_dates(1,:)=[];

log_prices=reshape(data(:,2),N,[]); %reshape by day group
log_prices=log_prices(s:kn:e,:); %pick up useful observations
log_returns=diff(log_prices);
end
