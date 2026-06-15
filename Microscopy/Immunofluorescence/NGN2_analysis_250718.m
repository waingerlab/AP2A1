%% 230912 NGN2 analysis
addpath('F:/Scripts/Universal_functions','F:\Scripts\Zeiss\fluorescence_quantification','F:\Scripts\Universal_functions\bfmatlab','F:\Scripts\Zeiss\Zstack');
cd('H:\240517_AP2A1_lentis');

%z-stack and turn into tifs
mkdir('tifs');
files = glob('*.czi');

for n=1:numel(files) %this writes out average of stack, not max projection
    [maxprojection] = zeisszstack_avg(files{n});
    newname = strrep(files{n},'\','_');
    saveastiff(maxprojection,strcat('tifs/',newname(1:end-3),'tif'));
end

cd('tifs'); %change directory

%information to write out- it writes the channel information in the ordrer
%of the tif stack (channel a is 2nd, channel b is 3rd
mkdir('masks');
files = glob('*.tif');
filenumber = numel(files);
datalabels = {'neurons','neuron_size','green_cyto','green_nuclear','green_total','green_ratio','red_cyto','red_nuclear','red_total','red_ratio','neuritearea_per_neuron'};
dataout = zeros(filenumber,numel(datalabels)); %preallocate space for writing out data
options.color = true;


nuclearchannel = 1;
nucleusminradius = 6;
cytoplasmchannel = 4;
nucleusstdevs = 2; %2 worked pretty well
cytoplasmstdevs =1.5;

parfor n=1:filenumber

file = files{n};
image = tifread(file);

[nuclearmask,cytomask,dilatedmask,neuritemask,backgroundmask,objectmask] = multichannelmask_v3_3(image,nuclearchannel,nucleusminradius,nucleusstdevs,cytoplasmchannel,cytoplasmstdevs);

% intensity measurements
neuronnumber=numel(unique(nuclearmask))-1; %need -1 to account for 0s of background
[~,tdp43_cyto,csize] = intensityfinder_v2(image(:,:,3),cytomask);
[~,tdp43_nuclear,nsize] = intensityfinder_v2(image(:,:,3),nuclearmask);
tdp43_total = tdp43_cyto+tdp43_nuclear;
tdp43_ratio = tdp43_nuclear./(tdp43_cyto+tdp43_nuclear);
neuronsize = csize+nsize;


[~,ptdp43_cyto,~] = intensityfinder_v2(image(:,:,2),cytomask);
[~,ptdp43_nuclear,~] = intensityfinder_v2(image(:,:,2),nuclearmask);
ptdp43_total = ptdp43_cyto+ptdp43_nuclear;
ptdp43_ratio = ptdp43_nuclear./(ptdp43_cyto+ptdp43_nuclear);

dataout(n,:)=[neuronnumber,mean(neuronsize),mean(tdp43_cyto),mean(tdp43_nuclear),mean(tdp43_total),mean(tdp43_ratio),mean(ptdp43_cyto),mean(ptdp43_nuclear),mean(ptdp43_total),mean(ptdp43_ratio),(sum(neuritemask>0,'all')/neuronnumber)];
saveastiff(objectmask,strcat('masks\',file(1:end-4),'mask.tif'),options);

end

xlswrite('staininganalysis.xlsx',dataout,'Summary','B2');
xlswrite('staininganalysis.xlsx',datalabels,'Summary','B1');
xlswrite('staininganalysis.xlsx',files,'Summary','A2');

%% reorganize spreadsheet

survivaldata=dataout;
%survivaldata = xlsread("staininganalysis",'Summary','b2:l161'); %used if
%data needs to be read in afterward


wellnum = [11 13 14];
%wellnum = [7,8,9,13,14,15,16,17,18]; %manually assign column numbers

reorganizedarray = cell(numel(wellnum),1);
reorganizedarraynames = cell(numel(wellnum),1);

%single digit string match
arraynum=1;
strings = cellfun(@(x) x(34:35),files,'UniformOutput',false); %well num to match, 16:17 may change depending on filename %%%%%ALWAYS EDIT THIS LINE WITH ZEISS FILES

for n=wellnum
    if n<10
        match = contains(strings,strcat(int2str(n),'-'));
        stringmatch = files(match);
        datamatch = survivaldata(match,:);
        reorganizedarray{arraynum}=datamatch;
        reorganizedarraynames{arraynum}=stringmatch;
        arraynum = arraynum+1;
    elseif n>=10
        match = contains(strings,int2str(n));
        stringmatch = files(match);
        datamatch = survivaldata(match,:);
        reorganizedarray{arraynum}=datamatch;
        reorganizedarraynames{arraynum}=stringmatch;
        arraynum=arraynum+1;
    end
end

%write out
file = 'staininganalysis.xlsx';
sheet = 'reorganized counts';
counter = 2;
for n=1:numel(reorganizedarray)
    xlswrite(file,reorganizedarraynames{n},sheet,strcat('A',int2str(counter)));
    xlswrite(file,reorganizedarray{n},sheet,strcat('B',int2str(counter)));
    counter = counter + 1+ numel(reorganizedarraynames{n});
end


%% plotting data
addpath('C:\Users\Aaron\Aaron_Data\Programming\MATLAB\Scripts\Graphs');

file = 'staininganalysis.xlsx';
sheet = 'TDP43WT';

sgCTRL = xlsread(file,sheet,'e2:e9');
sgMTMR6 = xlsread(file,sheet,'e29:e36');


proximity = 2e5;
lim = [0 6e6];
points = [0 3e6 6e6];
pointlabels = {'0','50','100'};
xspread = .1;
pointsize = 60;


datacolumns = {sgCTRL,sgMTMR6};
beeswarmbar_narrow(datacolumns,proximity,lim,points,pointlabels,xspread,pointsize)

%PR
sgCTRL = xlsread(file,sheet,'j104:j118');
sgMTMR6g1 = xlsread(file,sheet,'j121:j135');
sgMTMR6g2 = xlsread(file,sheet,'j138:j152');

proximity = 9e5;
lim = [0 4e7];
points = [0 2e7 4e7];
pointlabels = {'0','50','100'};
xspread = .1;
pointsize = 60;


datacolumns = {sgCTRL,sgMTMR6g1,sgMTMR6g2};
beeswarmbar_narrow(datacolumns,proximity,lim,points,pointlabels,xspread,pointsize)