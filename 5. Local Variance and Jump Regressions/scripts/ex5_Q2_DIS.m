addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');
[dates_DIS,lp_DIS]=load_stock('DIS.csv','m');
N_DIS=sum(floor(dates_DIS(1,1))==floor(dates_DIS(:,1)));% number of observations per day
T_DIS=size(dates_DIS,1)/N_DIS;
[rdates_DIS,lr_DIS]=log_return([dates_DIS lp_DIS],N_DIS,1);
days_DIS=unique(floor(rdates_DIS));

%2A
a=5;
[lr_c_DIS,lr_d_DIS]=c_d_log_returns(lr_DIS,N_DIS-1,a);
indi_DIS=find(lr_d_DIS~=0);
n=size(lr_c_DIS,1);
kn=11;
%left and right limit local variance
ct1=zeros(n,T_DIS);
ct2=zeros(n,T_DIS);
for i=2:n-1
    j2=max(1,i-kn);%start
    j1=min(kn+i,n);%stop
    ct1(i,:)=sum(lr_c_DIS(j2:i,:).^2,1)/((i-j2)/n);%left
    ct2(i,:)=sum(lr_c_DIS(i:j1,:).^2,1)/((j1-i)/n);%right
end

%plot jump left and right local variance at jump return time
figure;
subplot(2,1,1);
plot(rdates_DIS(indi_DIS),ct1(indi_DIS),'^','linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct2(indi_DIS),'o','linewidth',0.8);

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$\hat{c_{i_t}^+}$');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Local Variance $\hat{c_{i_t}}$ of DIS '); 
datetick('x','keeplimits');

subplot(2,1,2);
plot(rdates_DIS(indi_DIS),abs(lr_d_DIS(indi_DIS)),'*','linewidth',1);
xlabel('Jump time');
ylabel('Magnitude of Jump returns');
legend('Jump return');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Magnitude of Jump returns of DIS'); 
datetick('x','keeplimits');


%2B
%To simplify the program ,we here just consider the jumps fall in the
%middle intervals
indi_DIS=find(lr_d_DIS~=0);
a1=find(indi_DIS.*(mod(indi_DIS,77)<=11));
a2=find(indi_DIS.*(mod(indi_DIS,77)>=66));
a=[a1; a2];
indi_DIS(a)=[];
j1_DIS=indi_DIS-11;
j2_DIS=indi_DIS+11;

left_sample_DIS=zeros(11,size(indi_DIS,1));
right_sample_DIS=zeros(11,size(indi_DIS,1));
for i=1:size(indi_DIS,1)
left_sample_DIS(:,i)=lr_c_DIS(j1_DIS(i):indi_DIS(i)-1);
right_sample_DIS(:,i)=lr_c_DIS(indi_DIS(i)+1:j2_DIS(i));
end

%bootstrap sample

r=1000;
sct1_DIS=zeros(r,size(indi_DIS,1));
sct2_DIS=zeros(r,size(indi_DIS,1));
parfor i=1:r
    newsample1=sbsample(left_sample_DIS,kn,size(indi_DIS,1));
    newsample2=sbsample(right_sample_DIS,kn,size(indi_DIS,1));
   sct1_DIS(i,:)=sum(newsample1.^2,1)/(kn/n);%left
   sct2_DIS(i,:)=sum(newsample2.^2,1)/(kn/n);%right
end
ct1_low_DIS = quantile(sct1_DIS, 0.025);
ct1_up_DIS = quantile(sct1_DIS, 0.975);
ct2_low_DIS = quantile(sct2_DIS, 0.025);
ct2_up_DIS = quantile(sct2_DIS, 0.975);

Notinter_DIS=sum((ct1_low_DIS>ct2_up_DIS)|(ct1_up_DIS<ct2_low_DIS));


% 
% num_in_DIS_d=sum(CI_low_DIS <=TV_DIS & CI_up_DIS >=TV_DIS);
% cover_rate_DIS_d=num_in_DIS_d/T_DIS;
figure;
subplot(2,1,1);
plot(rdates_DIS(indi_DIS),ct1(indi_DIS),'^','linewidth',0.8);
hold on;
%plot(rdates_DIS(indi_DIS),ct2(indi_DIS),'linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct1_low_DIS,'--');
hold on;
plot(rdates_DIS(indi_DIS),ct1_up_DIS,'--');
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$CI_{left}^{lower}$','$CI_{left}^{up}$');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Local Variance $\hat{c_{i_t}}$ of DIS '); 
datetick('x','keeplimits');

%----right
subplot(2,1,2);
plot(rdates_DIS(indi_DIS),ct2(indi_DIS),'o','linewidth',0.8,'color',[0.8500 0.3250 0.0980]);
hold on;
%plot(rdates_DIS(indi_DIS),ct2(indi_DIS),'linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct2_low_DIS,'--');
hold on;
plot(rdates_DIS(indi_DIS),ct2_up_DIS,'--');
hold off;


xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^+}$','$CI_{right}^{lower}$','$CI_{right}^{up}$');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Local Variance $\hat{c_{i_t}}$ of DIS '); 
datetick('x','keeplimits');

%put together
figure;
subplot(2,1,1);
plot(rdates_DIS(indi_DIS),ct1(indi_DIS),'^','linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct2(indi_DIS),'o','linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct1_low_DIS,'--');
hold on;
plot(rdates_DIS(indi_DIS),ct2_up_DIS,'--');
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$\hat{c_{i_t}^+}$','$CI_{left}^{lower}$','$CI_{right}^{up}$');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Local Variance $\hat{c_{i_t}}$ of DIS '); 
datetick('x','keeplimits');

%----right
subplot(2,1,2);
plot(rdates_DIS(indi_DIS),ct1(indi_DIS),'^','linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct2(indi_DIS),'o','linewidth',0.8);
hold on;
plot(rdates_DIS(indi_DIS),ct2_low_DIS,'--');
hold on;
plot(rdates_DIS(indi_DIS),ct1_up_DIS,'--');
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$\hat{c_{i_t}^-}$','$\hat{c_{i_t}^+}$','$CI_{right}^{lower}$','$CI_{left}^{up}$');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Local Variance $\hat{c_{i_t}}$ of DIS '); 
datetick('x','keeplimits');

%CI together
figure;
plot(rdates_DIS(indi_DIS),ct1_low_DIS,'-','color',[0 0.4470 0.7410]);
hold on;
plot(rdates_DIS(indi_DIS),ct1_up_DIS,'-','color',[0 0.4470 0.7410]);
hold on;
plot(rdates_DIS(indi_DIS),ct2_low_DIS,'--','color',[0.8500 0.3250 0.0980]);
hold on;
plot(rdates_DIS(indi_DIS),ct2_up_DIS,'--','color',[0.8500 0.3250 0.0980]);
hold off;

xlabel('Jump time');
ylabel('Local Variance $\hat{c_{i_t}}$');
legend('$CI_{left}^{lower}$','$CI_{left}^{up}$','$CI_{right}^{lower}$','$CI_{right}^{up}$');
xlim([min(rdates_DIS(indi_DIS)),max(rdates_DIS(indi_DIS))]);
title('Local Variance $\hat{c_{i_t}}$ of DIS '); 
datetick('x','keeplimits');









