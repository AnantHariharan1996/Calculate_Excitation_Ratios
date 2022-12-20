function [kappa] = GetBulkMod(vp,vs,rho)
% vs = sqrt(mu/rho)
% vp = sqrt((kappa+(4/3)mu)/rho)
[mu] = GetShearMod(vs,rho);
Kappa = (vp.^2).*rho - (4/3).*mu;

end