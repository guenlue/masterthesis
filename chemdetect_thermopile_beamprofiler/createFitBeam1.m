function [fitresult, gof] = createFitBeam1(zDcut, diff)

[xData, yData] = prepareCurveData( zDcut, diff );

% Set up fittype and options.
ft = fittype('d0*sqrt(1+((x-zoffset)./zr).^2)','independent',{'x'},'coefficients',{'d0','zoffset','zr'});
%ft = fittype('a*exp(-x/b)+c','independent',{'x'},'coefficients',{'a','b','c'});
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
%opts.Display = 'iter';
opts.StartPoint = [10 10 1];
%opts.TolFun = 1e-20;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData,'o');
% legend( h, 'beam', 'fit', 'Location', 'NorthEast' );
% xlabel('beampath / mm');
% ylabel('beamprofile value / mm');
% ylim([0 max(yData)]);
% grid on;
end