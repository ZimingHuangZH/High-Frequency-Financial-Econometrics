function [X,Y] = simulation(var1,var2,var3,N,beta)
noise=random('normal',0,sqrt(var3),N,1);
X=random('normal',0,sqrt(var1),N,1)+noise;
u=random('normal',0,sqrt(var2),N,1);
Y=beta'.*X+u;
end

