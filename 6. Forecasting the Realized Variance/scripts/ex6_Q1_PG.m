addpath('D:\ZM-Documents\MATLAB\data\Stocks5Min','functions','scripts');
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

%1B
step=1;
X=RV_PG;
Y=RV_PG;
J=1000-1;%row number of independent variable 
fRV_AR1_PG1=zeros(T_PG-J-1,1);%t increase
fRV_HAR1_PG1=zeros(T_PG-J-1,1);
%fRV_NC_PG=zeros(T_PG-J);



for T=J+1:T_PG-1% the newest data used to estimate beta
    fRV_AR1_PG1(T-J)=AR(X,Y,J,T,step);
    fRV_HAR1_PG1(T-J)=HAR(X,Y,J,T,step);
end    
ERR_AR1_PG1=(mean((Y(J+2:T_PG)-fRV_AR1_PG1).^2));
ERR_HAR1_PG1=(mean((Y(J+2:T_PG)-fRV_HAR1_PG1).^2));
ERR_CN_PG1=(mean((Y(J+2:T_PG)-Y(J+1:T_PG-1)).^2));


%1C
J=250-1;
fRV_AR1_PG2=zeros(T_PG-J-1,1);%t increase
fRV_HAR1_PG2=zeros(T_PG-J-1,1);
%fRV_NC_PG=zeros(T_PG-J);

for T=J+1:T_PG-1
    fRV_AR1_PG2(T-J)=AR(X,Y,J,T,step);
    fRV_HAR1_PG2(T-J)=HAR(X,Y,J,T,step);
end    
ERR_AR1_PG2=(mean((Y(J+2:T_PG)-fRV_AR1_PG2).^2));
ERR_HAR1_PG2=(mean((Y(J+2:T_PG)-fRV_HAR1_PG2).^2));
ERR_CN_PG2=(mean((Y(J+2:T_PG)-Y(J+1:T_PG-1)).^2));


J=500-1;
fRV_AR1_PG3=zeros(T_PG-J-1,1);%t increase
fRV_HAR1_PG3=zeros(T_PG-J-1,1);
fRV_NC_PG3=zeros(T_PG-J);

for T=J+1:T_PG-1
    fRV_AR1_PG3(T-J)=AR(X,Y,J,T,step);
    fRV_HAR1_PG3(T-J)=HAR(X,Y,J,T,step);
end    
ERR_AR1_PG3=(mean((Y(J+2:T_PG)-fRV_AR1_PG3).^2));
ERR_HAR1_PG3=(mean((Y(J+2:T_PG)-fRV_HAR1_PG3).^2));
ERR_CN_PG3=(mean((Y(J+2:T_PG)-Y(J+1:T_PG-1)).^2));

%1D

% ERR_AR1_PG4=zeros(351,1);
% ERR_HAR1_PG4=zeros(351,1);
% ERR_CN_PG4=zeros(351,1);
% for J=250-1:5:2000-1
% fRV_AR1_PG1=zeros(T_PG-J-1,1);%t increase
% fRV_HAR1_PG1=zeros(T_PG-J-1,1);
%   for T=J+1:T_PG-1% the newest data used to estimate beta
%     fRV_AR1_PG1(T-J)=AR(X,Y,J,T,step);
%     fRV_HAR1_PG1(T-J)=HAR(X,Y,J,T,step);
%   end    
% ERR_AR1_PG4((J+1)/5-49)=(mean((Y(J+2:T_PG)-fRV_AR1_PG1).^2));
% ERR_HAR1_PG4((J+1)/5-49)=(mean((Y(J+2:T_PG)-fRV_HAR1_PG1).^2));
% ERR_CN_PG4((J+1)/5-49)=(mean((Y(J+2:T_PG)-Y(J+1:T_PG-1)).^2));
% end
% 
% 
% figure;
% plot(250:5:2000,ERR_AR1_PG4,'linewidth',1);
% hold on;
% plot(250:5:2000,ERR_HAR1_PG4,'linewidth',1);
% hold on;
% plot(250:5:2000,ERR_CN_PG4,'linewidth',1);
% legend('AR1','HAR1','NC');
% title('MSE of PG with Different Window Size(W=250-2000)');









