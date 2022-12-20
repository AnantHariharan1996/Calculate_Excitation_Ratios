function [radout] = km2rad_anysphere(km,sphere_radius)
% Since MATLAB's km2rad function only works with
% a few planetary bodies, here's one that works for any body,
% assuming sphere of course
radout = km / sphere_radius;
end