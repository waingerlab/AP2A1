%% batch script for zeisszstack
%move to the folder containing your czi files. This script will do a
%z-stack and then save the stacked images and individual channels
addpath('I:/Scripts/Universal_functions','I:\Scripts\Universal_functions\bfmatlab','I:\Scripts\Zeiss\Zstack'); %change this to the paths on your computer

%make directories
mkdir('tifs');
mkdir('tifs/C1');
mkdir('tifs/C2');
mkdir('tifs/C3');
mkdir('tifs/C4');

files = glob('*.czi');

for n=1:numel(files)
    [maxprojection] = zeisszstack_avg(files{n});
    newname = strrep(files{n},'\','_');
    saveastiff(maxprojection,strcat('tifs/',newname(1:end-3),'tif'));
    for nn=1:numel(maxprojection(1,1,:))
        saveastiff(maxprojection(:,:,nn),strcat('tifs/C',int2str(nn),'/',newname(1:end-4),'-C',int2str(nn),'.tif'));
    end
end