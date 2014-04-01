function plot3d(v,data,varargin)
% plot spherical data
%
% Syntax
%   plot3d(v,data)
%
% Input
%
% See also
% savefigure

% -------------------- GET OPTIONS ----------------------------------------

% where to plot
if check_option(varargin,'parent')
  ax = get_option(varargin,'parent');
else
  ax = gca;
end

% plot
surf(v.x,v.y,v.z,reshape(data,size(v,1),size(v,2),[]),'parent',ax);

shading(ax,'interp');
axis(ax,'equal','vis3d','off');
axis on
c = caxis(ax);
arrow3d(zeros(3),eye(3)*1.5,15,'cylinder',[0.15,0.15]);
caxis(ax,c);

text(1.6,0,0,'x','FontSize',15,'parent',ax)
text(0,1.6,0,'y','FontSize',15,'parent',ax)
text(0,0,1.6,'z','FontSize',15,'parent',ax)
%set(gca,'position',[-0.3,-0.3,1.6,1.6]);

set(ax,'XDir','rev','YDir','rev',...
'XLim',[-1.5,1.5],'YLim',[-1.5,1.5],'ZLim',[-1.5,1.5]);
