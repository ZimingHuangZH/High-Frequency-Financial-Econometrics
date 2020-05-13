addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_PG,lp_PG]=load_stock('PG.csv','m');
N_PG=sum(floor(dates_PG(1,1))==floor(dates_PG(:,1)));% number of observations per day
T_PG=size(dates_PG,1)/N_PG;
[rdates_PG,lr_PG]=log_return([dates_PG lp_PG],N_PG,1);
days_PG=unique(floor(rdates_PG));

%2A
a=5;
[lr_c_PG,lr_d_PG]=c_d_log_returns(lr_PG,N_PG-1,a);
indi_PG=find(lr_d_PG~=0);
n=size(lr_c_PG,1);
kn=11;
%left and right limit local variance
ct1=zeros(n,T_PG);
ct2=zeros(n,T_PG);
for i=2:n-1
    j2=max(1,i-kn);%start
    j1=min(kn+i,n);%stop
    ct1(i,:)=sum(lr_c_PG(j2:i,:).^2,1)/((i-j2)/n);%left
    ct2(i,:)=sum(lr_c_PG(i:j1,:).^2,1)/((j1-i)/n);%right
end

%plot jump left and right local variance at jump return time
figure;
subplot(2,1,1);
plot(rdates_PG(indi_PG),ct1(indi_PG),'^','linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct2(indi_PG),'o','linewidth',0.8);

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$\hat{c_{i_t}^+}$');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Local Variance $\hat{c_{i_t}}$ of PG '); 
datetick('x','keeplimits');

subplot(2,1,2);
plot(rdates_PG(indi_PG),abs(lr_d_PG(indi_PG)),'*','linewidth',1);
xlabel('Jump time');
ylabel('Magnitude of Jump returns');
legend('Jump return');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Magnitude of Jump returns of PG'); 
datetick('x','keeplimits');


%2B
%To simplify the program ,we here just consider the jumps fall in the
%middle intervals
indi_PG=find(lr_d_PG~=0);
a1=find(indi_PG.*(mod(indi_PG,77)<=11));
a2=find(indi_PG.*(mod(indi_PG,77)>=66));
a=[a1; a2];
indi_PG(a)=[];
j1_PG=indi_PG-11;
j2_PG=indi_PG+11;

left_sample_PG=zeros(11,size(indi_PG,1));
right_sample_PG=zeros(11,size(indi_PG,1));
for i=1:size(indi_PG,1)
left_sample_PG(:,i)=lr_c_PG(j1_PG(i):indi_PG(i)-1);
right_sample_PG(:,i)=lr_c_PG(indi_PG(i)+1:j2_PG(i));
end

%bootstrap sample

r=1000;
sct1_PG=zeros(r,size(indi_PG,1));
sct2_PG=zeros(r,size(indi_PG,1));
parfor i=1:r
    newsample1=sbsample(left_sample_PG,kn,size(indi_PG,1));
    newsample2=sbsample(right_sample_PG,kn,size(indi_PG,1));
   sct1_PG(i,:)=sum(newsample1.^2,1)/(kn/n);%left
   sct2_PG(i,:)=sum(newsample2.^2,1)/(kn/n);%right
end
ct1_low_PG = quantile(sct1_PG, 0.025);
ct1_up_PG = quantile(sct1_PG, 0.975);
ct2_low_PG = quantile(sct2_PG, 0.025);
ct2_up_PG = quantile(sct2_PG, 0.975);

Notinter_PG=sum((ct1_low_PG>ct2_up_PG)|(ct1_up_PG<ct2_low_PG));


% 
% num_in_PG_d=sum(CI_low_PG <=TV_PG & CI_up_PG >=TV_PG);
% cover_rate_PG_d=num_in_PG_d/T_PG;
figure;
subplot(2,1,1);
plot(rdates_PG(indi_PG),ct1(indi_PG),'^','linewidth',0.8);
hold on;
%plot(rdates_PG(indi_PG),ct2(indi_PG),'linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct1_low_PG,'--');
hold on;
plot(rdates_PG(indi_PG),ct1_up_PG,'--');
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$CI_{left}^{lower}$','$CI_{left}^{up}$');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Local Variance $\hat{c_{i_t}}$ of PG '); 
datetick('x','keeplimits');

%----right
subplot(2,1,2);
plot(rdates_PG(indi_PG),ct2(indi_PG),'o','linewidth',0.8,'color',[0.8500 0.3250 0.0980]);
hold on;
%plot(rdates_PG(indi_PG),ct2(indi_PG),'linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct2_low_PG,'--');
hold on;
plot(rdates_PG(indi_PG),ct2_up_PG,'--');
hold off;


xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^+}$','$CI_{right}^{lower}$','$CI_{right}^{up}$');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Local Variance $\hat{c_{i_t}}$ of PG '); 
datetick('x','keeplimits');

%put together
figure;
subplot(2,1,1);
plot(rdates_PG(indi_PG),ct1(indi_PG),'^','linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct2(indi_PG),'o','linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct1_low_PG,'--');
hold on;
plot(rdates_PG(indi_PG),ct2_up_PG,'--');
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$\hat{c_{i_t}^+}$','$CI_{left}^{lower}$','$CI_{right}^{up}$');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Local Variance $\hat{c_{i_t}}$ of PG '); 
datetick('x','keeplimits');

%----right
subplot(2,1,2);
plot(rdates_PG(indi_PG),ct1(indi_PG),'^','linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct2(indi_PG),'o','linewidth',0.8);
hold on;
plot(rdates_PG(indi_PG),ct2_low_PG,'--');
hold on;
plot(rdates_PG(indi_PG),ct1_up_PG,'--');
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$\hat{c_{i_t}^+}$','$CI_{right}^{lower}$','$CI_{left}^{up}$');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Local Variance $\hat{c_{i_t}}$ of PG '); 
datetick('x','keeplimits');

%CI together
figure;
plot(rdates_PG(indi_PG),ct1_low_PG,'-','color',[0 0.4470 0.7410]);
hold on;
plot(rdates_PG(indi_PG),ct1_up_PG,'-','color',[0 0.4470 0.7410]);
hold on;
plot(rdates_PG(indi_PG),ct2_low_PG,'--','color',[0.8500 0.3250 0.0980]);
hold on;
plot(rdates_PG(indi_PG),ct2_up_PG,'--','color',[0.8500 0.3250 0.0980]);
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$CI_{left}^{lower}$','$CI_{left}^{up}$','$CI_{right}^{lower}$','$CI_{right}^{up}$');
xlim([min(rdates_PG(indi_PG)),max(rdates_PG(indi_PG))]);
title('Local Variance $\hat{c_{i_t}}$ of PG '); 
datetick('x','keeplimits');









