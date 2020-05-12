function [return_dates,log_returns] = log_return(data,N,J)

%data is a 2 column matrix where the first column is date, 
%the second column is the log-price 
%data=[dates, log-price]
%N is the number of observations every day
%J is the number of steps between observations
%output are return_dates and log_return: they are group by day and shown in matrix 
return_dates=reshape(data(:,1),N,[]); %reshape by day group
return_dates=return_dates(1:J:end,:); %pick up useful observations
return_dates(1,:)=[];

log_prices=reshape(data(:,2),N,[]); %reshape by day group
log_prices=log_prices(1:J:end,:); %pick up useful observations
log_returns=diff(log_prices);

end




