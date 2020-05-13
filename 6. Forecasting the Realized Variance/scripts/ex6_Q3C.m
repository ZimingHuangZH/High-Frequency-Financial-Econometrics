addpath('D:\ZM-Documents\MATLAB\data\Stocks5Min','functions','scripts');
Name=char('AAPL.csv','AXP.csv','BA.csv','BAC.csv','BLK.csv','C.csv','CAT.csv',...
    'CSCO.csv','CVX.csv','DIS.csv','GE.csv','GNTX.csv','GS.csv','HD.csv','IBM.csv','INTC.csv',...
    'JNJ.csv','JPM.csv','KO.csv','MCD.csv','MET.csv','MMC.csv','MMM.csv','MRK.csv','MS.csv','MSFT.csv','NKE.csv',...
    'PFE.csv','PG.csv','PNC.csv','SPY.csv','STT.csv','TSLA.csv','UNH.csv','UTX.csv','VZ.csv','WMT.csv','XOM.csv');
J=1000-1;
step=1;


ERR_AR=zeros(size(Name,1),1);
ERR_HAR=zeros(size(Name,1),1);
ERR_adjAR=zeros(size(Name,1),1);
ERR_adjHAR=zeros(size(Name,1),1);
ERR_NC=zeros(size(Name,1),1);

for i=1:size(Name,1)
[ERR_AR(i),ERR_HAR(i),ERR_adjAR(i),ERR_adjHAR(i),ERR_NC(i)] = MSE(strtrim(Name(i,:)),J,step);
end

ERR=[ERR_AR,ERR_HAR,ERR_NC,ERR_adjAR,ERR_adjHAR];
figure;
bar(ERR);
xlabel('Stock Name');
ylabel('Model Estimated Error');
title('Model Estimated Error');
legend('AR1','HAR','NC','ARQ1','HARQ1');

figure;
plot(1:38,ERR,'linewidth',1);
xlabel('Stock Name');
xlim([1,38]);
ylabel('Model Estimated Error');
title('Model Estimated Error');
legend('AR1','HAR','NC','ARQ1','HARQ1');




