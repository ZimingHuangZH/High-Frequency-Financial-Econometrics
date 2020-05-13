function [m,mi,ma,q1,q2] = summary(data)
m=mean(data);
mi=min(data);
ma=max(data);
q1=quantile(data,0.05);
q2=quantile(data,0.95);
end

