function [lambda] = GetLameParameterLambda(vp,vs,rho)
% vs = sqrt(mu/rho)
% vp = sqrt((kappa+(4/3)mu)/rho)
% K = lambda + (2/3)mu
[Kappa] = GetBulkMod(vp,vs,rho);
[mu] = GetShearMod(vs,rho);
lambda = Kappa - (2/3).*mu;
end