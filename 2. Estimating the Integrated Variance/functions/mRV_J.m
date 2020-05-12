function [mRV_J] = mRV_J(file_name)
addpath('functions');
data=csvread(file_name);
log_prices=log(data(:,3));
log_prices=reshape(log_prices,4621,[]); %reshape by day group

rv_J_STOCK=[];
for J=1:120
    rv_J_STOCK(:,J)=realized_var(diff(log_prices(1:J:end,:)));
end
mean_rv_J_STOCK=mean(rv_J_STOCK);
mRV_J=mean_rv_J_STOCK-mean(mean_rv_J_STOCK);
end