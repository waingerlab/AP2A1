%% This script takes Zeiss CZI files, does a maximum intensity projection, and saves the TIF

function [maxprojection] = zeisszstack_series(file,colors)

image = bfopen(file);
planes = numel(image{1}(:,1))/colors;
dimensions = size(image{1}{1});
maxprojection = zeros(dimensions(1),dimensions(2),colors,'uint16');
scenes = numel(image(:,1));

for m = 1:scenes
    for n = 1:colors
        tempstack = zeros(dimensions(1),dimensions(2),'uint16');
        for nn=1:planes
            tempstack(:,:,nn) = image{m}{n+(colors*nn-colors)};
        end
        maxprojection(:,:,n) = max(tempstack,[],3);
    end
    saveastiff(maxprojection, strcat('tifs/',file(1:end-4),'_',int2str(m),'.tif'))
end
        