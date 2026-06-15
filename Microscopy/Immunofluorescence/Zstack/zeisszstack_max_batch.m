%% batch script for zeisszstack


%% For individual stacks
addpath('F:/Scripts/Universal_functions','F:\Scripts\Universal_functions\bfmatlab','F:\Scripts\Zeiss\Zstack');
cd('F:\241204_Drosophila_TDP43_NMJs');


mkdir('tifs');
files = glob('*.czi');

for n=1:numel(files)
    [maxprojection] = zeisszstack_max(files{n});
    newname = strrep(files{n},'\','_');
    saveastiff(maxprojection,strcat('tifs/',newname(1:end-3),'tif'));
end

%% For image series (one file, multiple scenes)

addpath('I:/Scripts/Universal_functions','I:\Scripts\Universal_functions\bfmatlab','I:\Scripts\Zeiss\Zstack');
cd('I:\Zeiss_examples\KOLF2.1');

%take CZI, do max projection, then save as TIF
mkdir('tifs');
file = glob('*.czi');
colors = 4;

zeisszstack_series(file{1},colors);



