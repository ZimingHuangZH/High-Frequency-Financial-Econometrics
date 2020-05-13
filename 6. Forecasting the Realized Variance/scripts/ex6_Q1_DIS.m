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

%1B
step=1;
X=RV_DIS;
Y=RV_DIS;
J=1000-1;%row number of independent variable 
fRV_AR1_DIS1=zeros(T_DIS-J-1,1);%t increase
fRV_HAR1_DIS1=zeros(T_DIS-J-1,1);
%fRV_NC_DIS=zeros(T_DIS-J);

for T=J+1:T_DIS-1% the newest data used to estimate beta
    fRV_AR1_DIS1(T-J)=AR(X,Y,J,T,step);
    fRV_HAR1_DIS1(T-J)=HAR(X,Y,J,T,step);
end    
ERR_AR1_DIS1=(mean((Y(J+2:T_DIS)-fRV_AR1_DIS1).^2));
ERR_HAR1_DIS1=(mean((Y(J+2:T_DIS)-fRV_HAR1_DIS1).^2));
ERR_CN_DIS1=(mean((Y(J+2:T_DIS)-Y(J+1:T_DIS-1)).^2));


%1C
J=250-1;
fRV_AR1_DIS2=zeros(T_DIS-J-1,1);%t increase
fRV_HAR1_DIS2=zeros(T_DIS-J-1,1);
%fRV_NC_DIS=zeros(T_DIS-J);

for T=J+1:T_DIS-1
    fRV_AR1_DIS2(T-J)=AR(X,Y,J,T,step);
    fRV_HAR1_DIS2(T-J)=HAR(X,Y,J,T,step);
end    
ERR_AR1_DIS2=(mean((Y(J+2:T_DIS)-fRV_AR1_DIS2).^2));
ERR_HAR1_DIS2=(mean((Y(J+2:T_DIS)-fRV_HAR1_DIS2).^2));
ERR_CN_DIS2=(mean((Y(J+2:T_DIS)-Y(J+1:T_DIS-1)).^2));


J=500-1;
fRV_AR1_DIS3=zeros(T_DIS-J-1,1);%t increase
fRV_HAR1_DIS3=zeros(T_DIS-J-1,1);
fRV_NC_DIS3=zeros(T_DIS-J);

for T=J+1:T_DIS-1
    fRV_AR1_DIS3(T-J)=AR(X,Y,J,T,step);
    fRV_HAR1_DIS3(T-J)=HAR(X,Y,J,T,step);
end    
ERR_AR1_DIS3=(mean((Y(J+2:T_DIS)-fRV_AR1_DIS3).^2));
ERR_HAR1_DIS3=(mean((Y(J+2:T_DIS)-fRV_HAR1_DIS3).^2));
ERR_CN_DIS3=(mean((Y(J+2:T_DIS)-Y(J+1:T_DIS-1)).^2));

%1D

% 
% ERR_AR1_DIS4=zeros(351,1);
% ERR_HAR1_DIS4=zeros(351,1);
% ERR_CN_DIS4=zeros(351,1);
% for J=250-1:5:2000-1
% fRV_AR1_DIS1=zeros(T_DIS-J-1,1);%t increase
% fRV_HAR1_DIS1=zeros(T_DIS-J-1,1);
%   for T=J+1:T_DIS-1% the newest data used to estimate beta
%     fRV_AR1_DIS1(T-J)=AR(X,Y,J,T,step);
%     fRV_HAR1_DIS1(T-J)=HAR(X,Y,J,T,step);
%   end    
% ERR_AR1_DIS4((J+1)/5-49)=(mean((Y(J+2:T_DIS)-fRV_AR1_DIS1).^2));
% ERR_HAR1_DIS4((J+1)/5-49)=(mean((Y(J+2:T_DIS)-fRV_HAR1_DIS1).^2));
% ERR_CN_DIS4((J+1)/5-49)=(mean((Y(J+2:T_DIS)-Y(J+1:T_DIS-1)).^2));
% end
% 
% 
% figure;
% plot(250:5:2000,ERR_AR1_DIS4,'linewidth',1);
% hold on;
% plot(250:5:2000,ERR_HAR1_DIS4,'linewidth',1);
% hold on;
% plot(250:5:2000,ERR_CN_DIS4,'linewidth',1);
% legend('AR1','HAR1','NC');
% title('MSE of DIS with Different Window Size(W=250-2000)');












