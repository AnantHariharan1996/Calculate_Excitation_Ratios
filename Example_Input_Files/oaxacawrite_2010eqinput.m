% write out 2010EQ input file
clear
azlist = [1:1:360];
for az = azlist;
    vec = [23 -2.290 -6.420 8.71 0.426 -0.570 -0.541 az];

mat(az,:) = vec;


end

dlmwrite(['Mw72_20100404.txt'],mat,'delimiter','\t','precision','%.6f')
