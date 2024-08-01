% write out 2010EQ input file
clear
azlist = [1:1:360];
for az = azlist;
    vec = [45 -1.090 0.358 0.734 1.750 -1.890 -0.652 az];

mat(az,:) = vec;


end

dlmwrite(['Mw72_20100404.txt'],mat,'delimiter','\t','precision','%.6f')
