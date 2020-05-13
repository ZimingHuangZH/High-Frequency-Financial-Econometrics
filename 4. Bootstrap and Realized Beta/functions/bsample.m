function [sample] = bsample(sample_base,kn,n,T)
%kn: the number of observation for every small interval
%n: the number of observations every day
M=n/kn;
intraday_offset=repmat(reshape(repmat(0:kn:(M-1)*kn,kn,1),[],1),1,T);
day_offset=repmat((0:n:(T-1)*n),n,1);
indices=randi(kn,n,T)+intraday_offset+day_offset;
sample=sample_base(indices);
end
