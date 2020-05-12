function [dates,log_prices] = load_stock(file_name,type)
%file_name: the name of data, is a string
%type: the minimal unit of observation frequency
%m: minutes
%s: seconds
data=csvread(file_name);

Y=floor(data(:,1)/10000); % year
M=floor((data(:,1)-Y*10000)/100); %month
D=data(:,1)-10000*Y-100*M; % day

if type=='m'
    H=floor(data(:,2)/100); %hour
    MN=data(:,2)-H*100; %minute
    S=0; %second
elseif type=='s'
    H=floor(data(:,2)/10000); %hour
    MN=floor(data(:,2)-H*10000)/100; %minute
    S=data(:,2)-10000*H-100*MN; %second
end

dates=datenum(Y,M,D,H,MN,S);
log_prices=log(data(:,3));

end

