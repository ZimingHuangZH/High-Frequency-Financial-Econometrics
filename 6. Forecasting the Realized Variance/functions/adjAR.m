function [fc,beta] = adjAR(X,Y,Qiv,J,T,step)
%J is the width of data window
%T+1 is forecasting day(newest available data-1)
%n is forecasting step number
%Y and X are available total data
x=zeros(J,2*step);
y1=zeros(2*step,1);
  for i=1:step
    x(:,2*i-1)=X(T-J+1-i:T-i);
    x(:,2*i)=Qiv(T-J+1-i:T-i).^(0.5).*X(T-J+1-i:T-i);
    y1(i)=X(T-i+1);
    y1(2*i)=Qiv(T-i+1).^(0.5).*X(T-i+1);
  end
%y is the denpendent variable vector: J*1 t-series data
%x is the indenpendent variable matrix: J*n t-series data * n variables 
%beta is the vestor of parameter: (n+1)*1
x=flipud(x);
y=flipud(Y(T-J+1:T)); 
beta=OLS(x,y);
%forecasting
y1=[y1;1];
fc=beta'*y1;
if fc<min(X(T-J+1-step:T)) || fc>max(X(T-J+1-step:T))
    fc=mean(X(T-J+1-step:T));
end

end


