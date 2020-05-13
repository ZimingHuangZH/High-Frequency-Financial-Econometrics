function [fc,beta] = HAR(X,Y,J,T,step)
%J is the width of X data window
%T+1 is forecasting day(newest available data-1)
%n is forecasting step number
%Y and X are available total data
x=zeros(J,3*step);
y1=zeros(3*step,1);
  for i=1:step
    x(:,3*i-2)=X(T-J+1-i:T-i);
    x(:,3*i-1)=movmean(X(T-J+1-i:T-i),[4,0]);
    x(:,3*i)=movmean(X(T-J+1-i:T-i),[21,0]);    
    y1(3*i-2)=X(T-i+1);
    y1(3*i-1)=mean(X(T-i+1-4:T-i+1));
    y1(3*i)=mean(X(T-i+1-21:T-i+1));
  end
%y is the denpendent variable vector: J*1 t-series data
%x is the indenpendent variable matrix: J*n t-series data * n variables 
%beta is the vestor of parameter: (n+1)*1
x=flipud(x(22:end,:));
y=flipud(Y(T-J+1+21:T)); 
beta=OLS(x,y);
  %forecasting
  y1=[y1;1];
  fc=beta'*y1;
  
if fc<min(X(T-J+1-step:T)) || fc>max(X(T-J+1-step:T))
     fc=mean(X(T-J+1-step:T));
end
  
  

end

