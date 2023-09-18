function [table] = copyfigurevaluestoclipboard(xdivider)
table=0;
allfigurehandles = findall(0,'type','figure');
str = {allfigurehandles.Name};
num = {allfigurehandles.Number};
num1 = cellfun(@num2str,num,'uni',false);
for i=1:size(str,2)
    str{1,i} = strcat(str{1,i},'---',num1{1,i});
end
[s,v] = listdlg('PromptString','select a figure:',...
    'SelectionMode','single',...
    'ListString',str);
%h = gcf; %current figure handle
axesObjs = get(allfigurehandles(s), 'Children');  %axes handles
disp(strcat('extracted values from ',num2str(s)));
k = size(axesObjs,1);
if k > 2
    disp('ERROR: Figure contains subplots - data extraction works not for subplots!');
    return
end
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
if k == 1
    objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    xdata = get(dataObjs, 'XData');  %data from low-level grahics objects
    ydata = get(dataObjs, 'YData');
else
    objTypes = get(dataObjs{2,1}, 'Type');  %type of low-level graphics object
    xdata = get(dataObjs{2,1}, 'XData');  %data from low-level grahics objects
    ydata = get(dataObjs{2,1}, 'YData');
end

if iscell(xdata)
    % get maxdata
    cellsz = cellfun(@size,xdata,'uni',false);
    maxlen = max(max(cell2mat(cellsz)));
    nrofkin = size(xdata,1);
    % initialize table
    table = zeros(maxlen,nrofkin);
    % fill table
    n = size(xdata,1);
    for i=1:n
        k = size(xdata{i,1},2);
        table(1:k,i*2) = xdata{i,1}'/xdivider;
        table(1:k,i*2-1) = ydata{i,1}';
    end
    table=fliplr(table);
else
    table = xdata'/xdivider;
    table(:,2) = ydata';
end
%clipboard('copy', mat2str(table)); % does not work
openvar('table');