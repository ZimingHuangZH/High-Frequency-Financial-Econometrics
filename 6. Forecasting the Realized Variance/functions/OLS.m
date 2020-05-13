function [beta] = OLS(x,y)
%J is the number of independent variables(step number)
%y is the denpendent variable vector: J*1 t-series data
%x is the indenpendent variable matrix: J*n t-series data * n variables 
% beta is the vestor of parameter: (n+1)*1
x(:,end+1)=1; % adding interception into regression
%beta=x'*y\(x'*x);
beta=(x'*x)\(x'*y);
end

