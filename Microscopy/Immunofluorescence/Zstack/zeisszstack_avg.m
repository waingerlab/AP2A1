%% This script takes Zeiss CZI files, does a maximum intensity projection, and saves the TIF

function [maxprojection] = zeisszstack_avg(file)

image = bfopen(file);
colors = image{1}{1,2};
colors = str2num(colors(end));
planes = numel(image{1}(:,1))/colors;
dimensions = size(image{1}{1});
maxprojection = zeros(dimensions(1),dimensions(2),colors,'uint16');

for n = 1:colors
    tempstack = zeros(dimensions(1),dimensions(2),'uint16');
    for nn=1:planes
        tempstack(:,:,nn) = image{1}{n+(colors*nn-colors)};
    end
    maxprojection(:,:,n) = mean(tempstack,3);
end
        