addpath('C:\Users\zmhua\Documents\MATLAB\data\Stocks5Sec','functions');
plotDefaults
%-------EXCERCISE 3 --------------
%Part B


IBM7=mRV_J('IBM-2007.csv');
IBM8=mRV_J('IBM-2008.csv');
IBM9=mRV_J('IBM-2009.csv');
IBM10=mRV_J('IBM-2010.csv');
IBM11=mRV_J('IBM-2011.csv');
IBM12=mRV_J('IBM-2012.csv');
IBM13=mRV_J('IBM-2013.csv');
IBM14=mRV_J('IBM-2014.csv');
IBM15=mRV_J('IBM-2015.csv');
IBM16=mRV_J('IBM-2016.csv');
IBM17=mRV_J('IBM-2017.csv');

J=1:120;
plot(J/10,IBM7);
hold on;
plot(J/10,IBM8);
hold on;
plot(J/10,IBM9);
hold on;
plot(J/10,IBM10);
hold on;
plot(J/10,IBM11);
hold on;
plot(J/10,IBM12);
hold on;
plot(J/10,IBM13);
hold on;
plot(J/10,IBM14);
hold on;
plot(J/10,IBM15);
hold on;
plot(J/10,IBM16);
hold on;
plot(J/10,IBM17);

xlabel('observe frequency(minute)');
ylabel('(adjusted)RV(\%)');
legend('IBM2007','IBM2008','IBM2009','IBM2010','IBM2011','IBM2012','IBM2013','IBM2014','IBM2015','IBM2016','IBM2017');
title('Average RV(adjusted by mean) with different frequency of IBM(2007-1017)');
