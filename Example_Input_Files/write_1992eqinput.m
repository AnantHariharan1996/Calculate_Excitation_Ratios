% write out 2010EQ input file
clear
azlist = [1:1:360];
for az = azlist;
    vec = [15 2.207 -0.790 -1.417 0.616 -6.389 0.454 az];

mat(az,:) = vec;


end

dlmwrite(['Mw72_19920425.txt'],mat,'delimiter','\t','precision','%.6f')
