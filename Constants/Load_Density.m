%% Load Density, 

PremNfo = load('PREM750_CARDS');
PREM_REF_Density = PremNfo(:,2);
PREM_REF_Radius_meters = PremNfo(:,1);

[unique_rads,uniquedx] = unique(PREM_REF_Radius_meters);
PREM_REF_Radius_meters=PREM_REF_Radius_meters(uniquedx);
PREM_REF_Density=PREM_REF_Density(uniquedx);