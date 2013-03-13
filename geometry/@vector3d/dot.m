function d = dot(v1,v2,varargin)
% pointwise inner product
%
%% Usage
% d = dot(v1,v2)
%
%% Input
%  v1, v2 - @vector3d
%
%% Options
%  antipodal - 
%
%% Output
%  double

% if second argument is Miller call corresponding method
if isa(v2,'Miller')
  d = dot(v2,v1,varargin{:});
  return
end

% compute dot product
xx = v1.x .* v2.x;
yy = v1.y .* v2.y;
zz = v1.z .* v2.z;
d = xx + yy + zz;

% 
if check_option(varargin,'antipodal') || check_option(v1,'antipodal') || check_option(v2,'antipodal')
  d = abs(d);
end
