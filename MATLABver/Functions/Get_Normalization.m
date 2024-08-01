function [scale] = Get_Normalization()
% From draw_eigfxn
% 1.d0/(rn*dsqrt(rn*pi*6.6723d-11)*5515.d0)
%[radius,rho,vsv,vsh,vpv,vph,qmu,qkappa,eta] = load_model(Velmod);

rn = 6371000;
scale = 1./(rn*sqrt(rn*pi*6.6723d-11)*5515);

end