function [ERR_AR,ERR_HAR,ERR_adjAR,ERR_adjHAR,ERR_CN] = MSE(name,J,step)
[dates,lp]=load_stock(name,'m');
N=sum(floor(dates(1,1))==floor(dates(:,1)));% number of observations per day
T=size(dates,1)/N;
[~,lr]=log_return([dates lp],N,1);

n=N-1;
a=5;
lr_c=c_d_log_returns(lr,N,a);

TV=transpose(sum(lr_c.^2));
Qiv=transpose(sum((n/3)*(lr_c.^4)));

X=TV;
Y=TV;
fRV_AR=zeros(T-J-1,1);%t increase
fRV_HAR=zeros(T-J-1,1);
fRV_adjAR=zeros(T-J-1,1);%t increase
fRV_adjHAR=zeros(T-J-1,1);

%t=J+1:T-1
 for t=J+1:T-1
    fRV_AR(t-J)=AR(X,Y,J,t,step);
    fRV_HAR(t-J)=HAR(X,Y,J,t,step);
    fRV_adjAR(t-J)=adjAR(X,Y,Qiv,J,t,step);
    fRV_adjHAR(t-J)=adjHAR(X,Y,Qiv,J,t,step);
end    
ERR_AR=(mean((Y(J+2:T)-fRV_AR).^2));
ERR_HAR=(mean((Y(J+2:T)-fRV_HAR).^2));
ERR_adjAR=(mean((Y(J+2:T)-fRV_adjAR).^2));
ERR_adjHAR=(mean((Y(J+2:T)-fRV_adjHAR).^2));
ERR_CN=(mean((Y(J+2:T)-Y(J+1:T-1)).^2));


end

