function [I] =indic(a,b,c)
% indicator function:to determine if a jump has happened before a give time
   if (c>=a & c<b)
      I=1;
   else
      I=0;
end

