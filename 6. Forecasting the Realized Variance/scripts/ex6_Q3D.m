addpath('D:\ZM-Documents\MATLAB\data\Stocks5Min','functions','scripts');
Name=char('AAPL.csv','AXP.csv','BA.csv','BAC.csv','BLK.csv','C.csv','CAT.csv',...
    'CSCO.csv','CVX.csv','DIS.csv','GE.csv','GNTX.csv','GS.csv','HD.csv','IBM.csv','INTC.csv',...
    'JNJ.csv','JPM.csv','KO.csv','MCD.csv','MET.csv','MMC.csv','MMM.csv','MRK.csv','MS.csv','MSFT.csv','NKE.csv',...
    'PFE.csv','PG.csv','PNC.csv','SPY.csv','STT.csv','TSLA.csv','UNH.csv','UTX.csv','VZ.csv','WMT.csv','XOM.csv');
J=1000-1;
step=1;


ERR_AR_T=zeros(size(Name,1),1);
ERR_HAR_T=zeros(size(Name,1),1);
ERR_adjAR_T=zeros(size(Name,1),1);
ERR_adjHAR_T=zeros(size(Name,1),1);
ERR_NC_T=zeros(size(Name,1),1);

for i=1:size(Name,1)
[ERR_AR_T(i),ERR_HAR_T(i),ERR_adjAR_T(i),ERR_adjHAR_T(i),ERR_NC_T(i)] = MSE_TV(strtrim(Name(i,:)),J,step);
end

ERR=[ERR_AR_T,ERR_HAR_T,ERR_NC_T,ERR_adjAR_T,ERR_adjHAR_T];
figure;
bar(ERR);
xlabel('Stock Name');
ylabel('Model Estimated Error(TV)');
title('Model Estimated Error');
legend('AR1','HAR','NC','ARQ1','HARQ1');

figure;
plot(ERR,'linewidth',1);
xlabel('Stock Name');
xlim([1,38]);
ylabel('Model Estimated Error');
title('Model Estimated Error(TV)');
legend('AR1','HAR','NC','ARQ1','HARQ1');




