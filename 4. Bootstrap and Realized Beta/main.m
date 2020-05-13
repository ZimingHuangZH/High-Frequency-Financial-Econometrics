addpath('D:\ZM-Documents\MATLAB\data','functions','scripts');

plot_defaults;
%exercise

%!!!
%to save time of checking the code in main.m, we just set repeat times r=10 here
%if you want to check each script, you have to set the repeat time for each scripts
%otherwise, the code won't run successfully

r=10;%set a small repeat number(please set r>=2, otherwise it may cause some problems when using "quantile" function)
p4_ex1_PG;
p4_ex1_DIS;
p4_ex1_f;

p4_ex2_PG;
p4_ex2_DIS;