function [radius,rho,vsv,vsh,vpv,vph,qmu,qkappa,eta] = read_carddeck(filename)

format='%s %s %s %s %s %s %s %s %s';
n=1000;

[sradius,srho,svpv,svsv,sqkap,sqmu,svph,svsh,seta]=textread(filename,format,n);
for i=1:length(sradius)-3
  radius(i)=str2num(sradius{i+3});
  rho(i)=str2num(srho{i+3});
  vsv(i)=str2num(svsv{i+3});
  vsh(i)=str2num(svsh{i+3});
  vpv(i)=str2num(svpv{i+3});
  vph(i)=str2num(svph{i+3});
  qmu(i)=str2num(sqmu{i+3});
  qkappa(i)=str2num(sqkap{i+3});
  eta(i)=str2num(seta{i+3});
end


