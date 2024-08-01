function [ MinorX, MajorX ] = Get_Love_Dist_Intersection( Period,MaxN )
% for two specific modes, with group velocity in km/s
% calculate the distance at which the modes intersect.
% assumes the same period...

% Get FM grpvel
fname=[ 'atl2a_Love_TUc_br' num2str(0) '.dms'];
tucinfo=load(fname);
Tlist=tucinfo(:,1);
Ulist=tucinfo(:,2);
Clist=tucinfo(:,3);

Tdiff = abs(Tlist-Period);
[mindiff,bestdx]=min(Tdiff);
U0 = Ulist(bestdx);    
    
% Get group velocities of overtones
OvertoneList = [1:1:MaxN];

for n = OvertoneList
    
    fname=[ 'atl2a_Love_TUc_br' num2str(n) '.dms'];
    tucinfo=load(fname);
    Tlist=tucinfo(:,1);
    Ulist=tucinfo(:,2);
    Clist=tucinfo(:,3);
    
    Tdiff = abs(Tlist-Period);
    [mindiff,bestdx]=min(Tdiff);
    U1(n) = Ulist(bestdx);    
    
end

% Returns distance traveled by the minor arc FM
% and the major arc higher mode in question

X = U0.*deg2km(360)./(U0+U1);

X = km2deg(X);

MinorX = X;
MajorX = km2deg(U1.*deg2km(360)./(U0+U1));


end

