%% Visualizing ODFs
% Explains all possibilities to visualize ODfs, i.e. pole figure plots,
% inverse pole figure plots, ODF sections, fibre sections.
%
%% Open in Editor
%
%% Contents
%
%%
% Let us first define some model ODFs to be plotted later on.

cs = symmetry('-3m'); ss = symmetry('-1');
mod1 = orientation('euler',90*degree,40*degree,110*degree,'ZYZ');
mod2 = orientation('euler',50*degree,30*degree,-30*degree,'ZYZ');

odf = 0.2*unimodalODF(mod1,cs,ss) ...
  + 0.3*unimodalODF(mod2,cs,ss) ...
  + 0.5*fibreODF(Miller(0,0,1),vector3d(1,0,0),cs,ss,'halfwidth',10*degree);
  

%%
% and lets switch to the LaboTex colormap
setMTEXpref('defaultColorMap',LaboTeXColorMap);


%% Pole Figures
% Plotting some pole figures of an <ODF_index.html ODF> is straight forward
% using the <ODF.plotpdf.html plotpdf> command. The only mandatory
% arguments are the ODF to be plotted and the <Miller_index.html Miller
% indice> of the crystal directions you want to have pole figures for.

plotpdf(odf,[Miller(1,0,-1,0),Miller(0,0,0,1)])

%%
% By default the <ODF.plotpdf.html plotpdf> command plots the upper as well
% a the lower hemisphere of each pole sphere. In order to superpose
% antipodal directions you have to use the option *antipodal*.

plotpdf(odf,[Miller(1,0,-1,0),Miller(0,0,0,1)],'antipodal')


%% Inverse Pole Figures
% Plotting inverse pole figures is analogously to plotting pole figures
% with the only difference that you have to use the command
% <ODF.plotipdf.html plotipdf> and you to specify specimen directions and
% not crystal directions.

plotipdf(odf,[xvector,zvector],'antipodal')
annotate(Miller(1,0,0),'labeled')

%%
% By default MTEX alway plots only the fundamental region with respect to
% the crystal symmetry. In order to plot the complete inverse pole figure
% you have to use the option *complete*.

plotipdf(odf,[xvector,zvector],'antipodal','complete')

%%
% By default MTEX always plot the fundamental region starting with azimuth
% angle rho = 0. Esspecially, if the x axis is plotted to north it might be
% desireable to plot the fundamental region starting with some negative
% value. To this end there is the option *minRho*.

plotx2north
plotipdf(odf,[xvector,zvector],'antipodal','minRho',-90*degree)
annotate(Miller(1,0,0),'labeled')
plotx2east

%% ODF Sections
%
% Plotting an ODF in two dimensional sections through the orientation space
% is done using the command <ODF.plotodf.html plot>. By default the
% sections are at constant angles phi2. The number of sections can be
% specified by an option

plot(odf,'sections',6,'silent')

%%
% One can also specify the phi2 angles of the sections explicitly

plot(odf,'phi2',[25 30 35 40]*degree,'contourf','silent')


%%
% Beside the standard phi2 sections MTEX supports also sections according
% to all other Euler angles. 
%
% * PHI2 (default)
% * PHI1 
% * ALPHA (Matthies Euler angles)
% * GAMMA (Matthies Euler angles)
% * SIGMA (alpha+gamma)
%
%%
% In this context the authors of MTEX recommends the sigma sections as they
% provide a much less distorted representation of the orientation space.
% They can be seen as the (001) pole figure splitted according to rotations
% about the (001) axis. Lets have a look at the 001 pole figure

plotpdf(odf,Miller(0,0,0,1))

%%
% We observe three spots. Two in the center and one at 100. When splitting
% the pole figure, i.e. plotting the odf as sigma sections

plot(odf,'sections',6,'silent','sigma')

%%
% we can clearly distinguish the two spots in the middle indicating two
% radial symmetric portions. On the other hand the spots at 001 appear in
% every section indicating a fibre at position [001](100). Knowing that
% sigma sections are nothing else then the splitted 001 pole figure they
% are much more simple to interprete then ussual phi2 sections.

%% 3D Euler Space
% Instead of sectioning one could plot the Euler Angles in 3D by using one
% of the options
%
% * contour3
% * surf3
% * slice3
%

plot(odf,'surf3')

%% Plotting the ODF along a fibre
% For plotting the ODF along a certain fibre we have the command

plotfibre(odf,Miller(1,2,2),vector3d(2,1,1),'LineWidth',2);

%% Fourier Coefficients
% A last way to visualize an ODF is to plot its Fourier coefficients

close all;
plotFourier(odf,'bandwidth',32)

%% Axis / Angle Distribution
% Let us consider the uncorrelated missorientation ODF corresponding to our
% model ODF.

mdf = calcMDF(odf)

%%
% Then we can plot the distribution of the rotation axes of this
% missorienation ODF

plotAxisDistribution(mdf)

%%
% and the distribution of the missorientation angles and compare them to a
% uniform ODF

plotAngleDistribution(mdf)
hold all
plotAngleDistribution(uniformODF(cs,cs))
hold off
legend('model ODF','uniform ODF')



%%
% Finally, lets set back the default colormap.

setMTEXpref('defaultColorMap',WhiteJetColorMap);
