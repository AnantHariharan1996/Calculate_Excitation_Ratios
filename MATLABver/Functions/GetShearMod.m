function [mu] = GetShearMod(vs,rho)
% vs = sqrt(mu/rho)
mu = (vs.^2).*rho;
end