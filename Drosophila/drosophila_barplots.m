%%Drosophila barplots

file = 'randomization_key.xlsx';
sheet = 'organized';

%ap2 subunits Tau
males =xlsread(file,sheet,'t3:x30') %ap2 subunits Tau
females = xlsread(file,sheet,'af3:aj32') %ap2 subunits Tau

%LC3 vs CLTC Tau
males =xlsread(file,sheet,'ag3:ai30') %ap2 subunits Tau
females = xlsread(file,sheet,'au3:aw28') %ap2 subunits Tau

%ap2 subunits GMR
males = xlsread(file,sheet,'e3:i30') %ap2 subunits GMR
females = xlsread(file,sheet,'p3:t30') %ap2 subunits GMR

%LC3 vs CLTC GMR
males = xlsread(file,sheet,'k3:m30') %ap2 subunits GMR
females = xlsread(file,sheet,'v3:x30') %ap2 subunits GMR


%preallocate groups - columns = score from 0-4, rows = genotype
group = males;
group = females
eyegroups = 5;

categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .2 .2]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]

%% STING plot for Christine

file = 'Autophagy_Endocytosis_screen_240322.xlsx';
sheet = 'Screen Results';

control = xlsread(file,sheet,'j3:k21');
control = control(:);
nrv1 = xlsread(file,sheet,'aq3:aq22');

group = nan(38,2);
group(:,1)=control;
group(1:20,2)=nrv1;

eyegroups = 5;

categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .2 .2]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]

%% ATP1A plots for Christine

file = 'Autophagy_Endocytosis_screen_240322.xlsx';
sheet = 'Screen Results';

noTDP43= zeros(20,1); %this is from the original observation, all were 0s
control = xlsread(file,sheet,'j3:k21');
control = control(:);
nrv1 = xlsread(file,sheet,'aj3:aj12');
nrv3 = xlsread(file,sheet,'ak3:ak16');

group = nan(38,4);
group(1:20,1)=noTDP43;
group(:,2)=control;
group(1:10,3)=nrv1;
group(1:14,4)=nrv3;

eyegroups = 5;

categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .2 .2]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% rescue plots for MassCATs

file = 'Autophagy_Endocytosis_screen_240322.xlsx';
sheet = 'Screen Results';

noTDP43= zeros(20,1); %this is from the original observation, all were 0s
control = xlsread(file,sheet,'j3:k21');
control = control(:);
mtmr6 = xlsread(file,sheet,'ai3:ai12');
rabgap = xlsread(file,sheet,'ax3:ax12');
heatr5b = xlsread(file,sheet,'ah3:ah9');
atg9 = xlsread(file,sheet,'v3:v18');
atxn2 = xlsread(file,sheet,'as3:as22');


group = nan(38,7); %make sure to change group number
group(1:20,1)=noTDP43;
group(:,2)=control;
group(1:10,3)=mtmr6;
group(1:10,4)=rabgap;
group(1:7,5)=heatr5b;
group(1:16,6)=atg9;
group(1:20,7)=atxn2;


eyegroups = 5;

categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]

%% AP2A1_LC3 MassCATs
file = 'AP2A1_LC3_MassCATs';
sheet = 'Sheet1';

tdp43=xlsread(file,sheet,'a3:d28');
ab=xlsread(file,sheet,'f3:I33');
tau=xlsread(file,sheet,'k3:n29');


eyegroups = 5;

group = tdp43;

categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% TDP43 Screen graphs

file = 'Autophagy_Endocytosis_PI_combined_240828.xlsx';
sheet = 'ByGroup';

controls=xlsread(file,sheet,'a3:b40');
endosome=xlsread(file,sheet,'d3:f27');
LC3processing=xlsread(file,sheet,'h3:m27');
membranesupply=xlsread(file,sheet,'o3:o27');
lysosomefusion=xlsread(file,sheet,'q3:q23');
membraneclosure=xlsread(file,sheet,'s3:s12');
nucleation=xlsread(file,sheet,'u3:u20');
PIprocessing=xlsread(file,sheet,'ad3:am29');
selective=xlsread(file,sheet,'ab3:ad27');
single=xlsread(file,sheet,'o3:r27');


group = tdp43; %change group name for each plot

eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% TDP43 Screen graphs 2

file = 'Autophagy_Endocytosis_PI_combined_240828';
sheet = 'ByGroup';

controls=xlsread(file,sheet,'a3:c40'); %and ATG9
endosome=xlsread(file,sheet,'e3:h27');
LC3processing=xlsread(file,sheet,'j3:p27');
lysosomefusion=xlsread(file,sheet,'s3:t23');
membraneclosure=xlsread(file,sheet,'s3:s12');
nucleation=xlsread(file,sheet,'x3:y20');
PIprocessing=xlsread(file,sheet,'ab3:aj29');
selective=xlsread(file,sheet,'al3:am27');
single=xlsread(file,sheet,'o3:r27');


group = controls; %change group name for each plot

eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% Tau attempted rescue graphs

file = 'Tau_randomization_key.xlsx';
sheet = 'Sheet1';

genotypes=xlsread(file,sheet,'h2:k21'); %and ATG9

group = genotypes; %change group name for each plot

eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% AB42 attempted rescue graphs

file = 'AB42_randomization_key.xlsx';
sheet = 'Sheet1';

genotypes=xlsread(file,sheet,'f2:i21'); %and ATG9

group = genotypes; %change group name for each plot

eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]

%% GR dipeptide rescue experiments
file = 'GR_randomization_key.xlsx';
sheet = 'Sheet2';

genotypes=xlsread(file,sheet,'i2:j21'); %and ATG9
genotypes2=xlsread(file,sheet,'r2:s13');
genotypes3=xlsread(file,sheet,'w2:x16');


group = genotypes3; %change group name for each plot

eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% TDP43-AP2A1 rescue
file = 'TDP43_AP2A1_randomization_key.xlsx';
sheet = 'Organized';

group=xlsread(file,sheet,'g2:i23'); 


eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% autolysosomal reformation
file = 'randomization_key.xlsx';
sheet = 'graphs';

group=xlsread(file,sheet,'k32:p49'); 


eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]


%% other AP complexes

file = 'randomization_key.xlsx';
sheet = 'graphs';

group=xlsread(file,sheet,'s32:z50'); 


eyegroups = 5;



categories = zeros(numel(group(1,:)),eyegroups);

for n=1: numel(group(1,:))
    tempdata = group(:,n);
    tempdata(isnan(tempdata))=[]; %delete NaNs
    totalanimals = numel(tempdata);
    for nn=0:eyegroups-1 %assuming eyegroups starts with 0
        categories(n,nn+1) = sum(tempdata==nn)/totalanimals;
    end
end


baroutput = bar(categories,'stacked')
baroutput(1).FaceColor = [1 .9 .9]
baroutput(2).FaceColor = [.8 .5 .5]
baroutput(3).FaceColor = [.5 .2 .2]
baroutput(4).FaceColor = [.3 .1 .1]
baroutput(5).FaceColor = [0 0 0]