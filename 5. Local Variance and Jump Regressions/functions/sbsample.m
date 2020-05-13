function [sample] = sbsample(sample_base,n,T)
%kn: the number of observation for every small interval
%n: the number of observations every day
day_offset=repmat((0:n:(T-1)*n),n,1);
indices=randi(n,n,T)+day_offset;
sample=sample_base(indices);
end
