function [V_beta,beta_hat] = beta_var(return1,return2,n,a,kn)
%return1 is the market return:n*T matrix
%return2 is the individual stock return:n*T matrix

return1=reshape(return1,n,[]);
return2=reshape(return2,n,[]);
[lr_c_1,lr_d_1]=c_d_log_returns(return1,n,a);
Pn=find(lr_d_1(:)~=0); %focus on jumps
%jump betalr
beta_hat=sum(return2(Pn).*return1(Pn))/sum(return1(Pn).^2);
%beta variance
lr_2=return2.*(lr_d_1==0); %since for x1 jump part, ce=0, so we just focus on the x2 return when x1 is continuous
lr_1=lr_c_1;
n=size(lr_2,1);
T=size(lr_2,2);
cet=zeros(n,T);
for i=1:n
    j2=max(1,i-kn);
    j1=min(kn+i,n);
    cet(i,:)=(n/(j1-j2+1))*sum((lr_2(j2:j1,:)-beta_hat*lr_1(j2:j1,:)).^2,1);
end

%estimate the variance of jump beta
V_beta=sum((return1(Pn).^2).*cet(Pn))/(sum(return1(Pn).^2))^2;
end
