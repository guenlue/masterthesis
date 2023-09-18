thispath = pwd;
include={'mytools','externaltools','newfunctions','ATR_calculations'};
slash = thispath(end-8:end-8);
for i=1:size(include,2)
addpath(genpath(strcat(thispath,'/',include{1,i})));
end
clear
disp(' ... gogogo!!!');