addpath('C:\Users\zmhua\Documents\MATLAB\data','functions');
BAC=csvread('BAC-2015.csv');
name='BAC';
%-------EXCERCISE 3 --------------

%Part B
% produce dates_prices matrix
[BAC_dates,BAC_prices]=load_stock('BAC-2015.csv','s');
% calculate N,T,n
N_BAC=sum(BAC(1,1)==BAC(:,1));% number of observations per day
n_BAC=N_BAC-1; % number of intervals per day
T_BAC=size(BAC,1)/N_BAC;

%Part C
% calculate RV for day1 with different frequency data
rv_J_BAC=[];
for J=1:120
    [BAC_rdates,BAC_lr]=log_return([BAC_dates,BAC_prices],N_BAC,J);
    rv_J_BAC(:,J)=realized_var(BAC_lr);
end
% plot RV for day 1 with different observe frequency
J=1:120;
figure;
plot(J/12,rv_J_BAC(1,:));
xlabel('observe frequency(minute)');
ylabel('RV(\%)');
title(['RV for day 1 with different frequency of ' name '(\%)']);
xlim([min(J/12),max(J/12)]);

%Part D
% calculate annual average RV with different frequency data
mean_rv_J_BAC=mean(rv_J_BAC);
% plot annual RV with different observe frequency
figure;
plot(J/12,mean_rv_J_BAC);
xlabel('observe frequency(minute)');
ylabel('RV(\%)');
title(['Average RV with different frequency of ' name '(\%)']);
xlim([min(J/12),max(J/12)]);

%Part E
% construct RV pair-difference matrix w.r.t different J
Diff_J_BAC=[]
for i=1:120
    for k=1:120
      Diff_J_BAC(i,k)=mean(abs(rv_J_BAC(:,i)-rv_J_BAC(:,k)));
    end
end

