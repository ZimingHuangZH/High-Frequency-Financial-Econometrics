addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_BAC,lp_BAC]=load_stock('BAC-2015.csv','s');
N_BAC=sum(floor(dates_BAC(1,1))==floor(dates_BAC(:,1)));% number of observations per day
T_BAC=size(dates_BAC,1)/N_BAC;
lp_BAC=reshape(lp_BAC,N_BAC,[]);
days_BAC=unique(floor(dates_BAC));

%B ave RV against kn
mkn=120;
RV_BAC=zeros(mkn,1);
for kn=1:mkn
  lr_BAC=log_return_new(lp_BAC,kn,1,N_BAC);
   RV_BAC(kn)=mean(sum(lr_BAC.^2));%average RV for given kn
end

figure;
plot(1/12:1/12:mkn/12,100*sqrt(252*RV_BAC));
xlabel('Sample Frequency(min)');
xlim([1/12,mkn/12]);
ylabel('Annualized RV(\%)');
title('Annualized RV of Different Sample Frequency (\%)');

%C estimate var_x using highest frequency
lr_BAC_HF=log_return_new(lp_BAC,1,1,N_BAC);
var_x_HF=(2*(N_BAC-1))^(-1)*sum(lr_BAC_HF.^2);

%E average contribution g=against varing kn
mkn=120;
cont=zeros(mkn,1);
for kn=1:mkn
  lr_BAC=log_return_new(lp_BAC,kn,1,N_BAC);
   RV_BAC=sum(lr_BAC.^2);
   %n_kn=floor((N_BAC-1)/kn);%n=(N_BAC-1)/kn
   n_kn=(N_BAC-1)/kn;%n=(N_BAC-1)/kn
   cont(kn)=100*mean(var_x_HF*(2*n_kn)./RV_BAC); %average contribution
end

figure;
plot(1/12:1/12:mkn/12,cont);
xlabel('Sample Frequency(min)');
xlim([1/12,mkn/12]);
ylim([0,100]);
ylabel('Average Contribution(\%) ');
title('Average Contribution of Different Sample Frequency (\%)');

%F average RV with different start interval j given kn=60
kn=60;
RV_BAC=zeros(kn,T_BAC);
for j=1:kn
  lr_BAC=log_return_new(lp_BAC,kn,j,N_BAC);
  RV_BAC(j,:)=sum(lr_BAC.^2);
end
RV_subave=mean(RV_BAC,1);

figure;
plot(days_BAC,100*sqrt(252*RV_subave));
hold on;
plot(days_BAC,100*sqrt(252*RV_BAC(1,:)));
xlabel('Time(day)');
xlim([min(days_BAC),max(days_BAC)]);
ylabel('Annualized RV(\%)');
title('Annualized RV$^{subave}$ and RV$^{5min}$(\%)');
datetick('x','keeplimits');
legend('RV$^{subave}$','RV$^{5min}$');

%G TSRV
%n_kn=floor((N_BAC-1)/kn); % given kn
kn=60;
n_kn=(N_BAC-1)/kn; % given kn
TSRV_BAC=RV_subave-var_x_HF*(2*n_kn);

figure;
plot(days_BAC,100*sqrt(252*TSRV_BAC));
hold on;
plot(days_BAC,100*sqrt(252*RV_BAC(1,:)));
xlabel('Time(day)');
xlim([min(days_BAC),max(days_BAC)]);
ylabel('Annualized RV(\%)');
title('Annualized TSRV and RV$^{5min}$ (\%)');
datetick('x','keeplimits');
legend('TSRV','RV$^{5min}$');

%H 
%Avg TSRV agaainst different kn
% 1 given kn, calculate RVj;
% 2 then calculate subave RV;
% 3 calculate TSRV
% 4 varing kn, calculate avg TSRV
mkn=120;
TSRV_BAC=zeros(mkn,T_BAC);
RV_ave=zeros(mkn,1); %average RV
for kn=1:mkn % 4 varing kn, calculate avg TSRV
  RV_BAC=zeros(kn,T_BAC); % 1 given kn, calculate RVj;
  for j=1:kn
   lr_BAC=log_return_new(lp_BAC,kn,j,N_BAC);
   RV_BAC(j,:)=sum(lr_BAC.^2);
  end
  RV_ave(kn)=mean(RV_BAC(1,:));
  RV_subave=mean(RV_BAC,1); % 2 then calculate subave RV;
  %n_kn=floor((N_BAC-1)/kn);
  n_kn=(N_BAC-1)/kn;
  TSRV_BAC(kn,:)=RV_subave-var_x_HF*(2*n_kn); % 3 calculate TSRV
end
TSRV_ave=mean(TSRV_BAC,2);

figure;
plot(2/12:1/12:mkn/12,100*sqrt(252*RV_ave(2:end)));
hold on;
plot(2/12:1/12:mkn/12,100*sqrt(252*TSRV_ave(2:end)));
xlabel('Sample Frequency(min)');
xlim([1/12,mkn/12]);
ylabel('Annualized RV(\%)');
title('Average Annualized TSRV and Volatility with Different Sample Frequency(\%)');
legend('$RV^{ave}$','TSRV');



