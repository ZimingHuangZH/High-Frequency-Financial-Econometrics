function [ct] = local_var(lr_c,kn)
%lr_c is a n*T diffusive return matrix
%where n is the observation number each day and T is the number of observative days
n=size(lr_c,1);
T=size(lr_c,2);
ct=zeros(n,T);
for i=1:n
    j2=max(1,i-kn);
    j1=min(kn+i,n);
    ct(i,:)=sum(lr_c(j2:j1,:).^2)/((j1-j2+1)/n);
end
end
