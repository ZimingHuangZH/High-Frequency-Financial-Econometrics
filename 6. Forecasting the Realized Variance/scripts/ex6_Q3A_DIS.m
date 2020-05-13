addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));

n=N_DIS-1;
a=5;
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS,a);

RV_DIS=transpose(sum(lr_DIS.^2));
QIV_DIS=transpose(sum((n/3)*(lr_c_DIS.^4)));

%3A
step=1;
X=RV_DIS;
Y=RV_DIS;
Qiv=QIV_DIS;
J=1000-1;
fRV_adjAR1_DIS=zeros(T_DIS-J-1,1);%t increase
fRV_adjHAR1_DIS=zeros(T_DIS-J-1,1);
%fRV_NC_DIS=zeros(T_DIS-J);

for T=J+1:T_DIS-1
    fRV_adjAR1_DIS(T-J)=adjAR(X,Y,Qiv,J,T,step);
    fRV_adjHAR1_DIS(T-J)=adjHAR(X,Y,Qiv,J,T,step);
end    
ERR_adjAR1_DIS=(mean((Y(J+2:T_DIS)-fRV_adjAR1_DIS).^2));
ERR_adjHAR1_DIS=(mean((Y(J+2:T_DIS)-fRV_adjHAR1_DIS).^2));
ERR_CN_DIS=(mean((Y(J+2:T_DIS)-Y(J+1:T_DIS-1)).^2));













