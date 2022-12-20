function [radius,rho,vsv,vsh,vpv,vph,qmu,qkap,eta] = load_model(filename)
% Load model
info = load(filename);
radius = info(:,1);
rho = info(:,2);
vpv = info(:,3);
vsv = info(:,4);
qkap = info(:,5);
qmu = info(:,6);
vph = info(:,7);
vsh = info(:,8);
eta = info(:,9);

end