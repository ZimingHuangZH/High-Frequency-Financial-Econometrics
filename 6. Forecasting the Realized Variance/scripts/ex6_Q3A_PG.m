addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));

n=N_PG-1;
a=5;
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG,a);

RV_PG=transpose(sum(lr_PG.^2));
QIV_PG=transpose(sum((n/3)*(lr_c_PG.^4)));

%3A
step=1;
X=RV_PG;
Y=RV_PG;
Qiv=QIV_PG;
J=1000-1;
fRV_adjAR1_PG=zeros(T_PG-J-1,1);%t increase
fRV_adjHAR1_PG=zeros(T_PG-J-1,1);
%fRV_NC_PG=zeros(T_PG-J);

for T=J+1:T_PG-1
    fRV_adjAR1_PG(T-J)=adjAR(X,Y,Qiv,J,T,step);
    fRV_adjHAR1_PG(T-J)=adjHAR(X,Y,Qiv,J,T,step);
end    
ERR_adjAR1_PG=(mean((Y(J+2:T_PG)-fRV_adjAR1_PG).^2));
ERR_adjHAR1_PG=(mean((Y(J+2:T_PG)-fRV_adjHAR1_PG).^2));
ERR_CN_PG=(mean((Y(J+2:T_PG)-Y(J+1:T_PG-1)).^2));













