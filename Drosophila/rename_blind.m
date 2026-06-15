%% renaming script for images
%The script copies a file, gives it a random name, saves it to the
%"randomized" folder, and prints out a key
% 
% it would be more robust to write in a check for non-repeating strings, but
%the odds of getting two repeating strings are extremely low


addpath('C:\Users\Aaron\Aaron_Data\Programming\MATLAB\Scripts\Universal_functions')
cd("C:\Users\Aaron\Aaron_Data\Drosophila\240328_TDP43")

files = glob('*\*.tif')

symbols = ['A':'Z'];
symbolnum = numel(symbols);
filekey = cell(numel(files),2);

mkdir('randomized')
for n=1:numel(files)
    filekey{n,1} = files{n};
    randomkey = strcat(symbols(randi(symbolnum,[1 10])),'.tif');
    filekey{n,2} = randomkey;
    copyfile(files{n}, strcat('randomized\',randomkey));
end

xlswrite("randomization_key.xlsx",filekey)