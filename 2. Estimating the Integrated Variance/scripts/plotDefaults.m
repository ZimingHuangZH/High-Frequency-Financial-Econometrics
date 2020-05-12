% plotDefaults.m
% this file determines the font sizes to be used across all plots,
% and changes some of the plots defaults so that we do not have to
% change them every time we plot a figure

% font sizes
fSize = struct('label',18,...
               'title',2,...
               'axis',12,...
               'legend',12,...
               'scatter',40);
fSize.labelmult = fSize.label/fSize.axis;
fSize.titlemult = fSize.title/fSize.axis;

% plot defaults
set(groot,'DefaultTextInterpreter','Latex');
set(groot,'DefaultAxesTitleFontSize', fSize.title);
set(groot,'DefaultAxesFontSize',fSize.axis);
set(groot,'DefaultLegendInterpreter','Latex');
set(groot,'DefaultLegendFontSize',fSize.legend,...
          'DefaultLegendFontSizeMode','manual');
set(groot,'DefaultAxesLabelFontSizeMultiplier',fSize.labelmult);
set(groot,'defaultLineLineWidth',1.5);
set(groot,'defaultLineLineStyle','-');
set(groot,'defaultLineColor','black');