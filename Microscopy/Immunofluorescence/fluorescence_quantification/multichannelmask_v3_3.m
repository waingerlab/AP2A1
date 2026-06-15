%% This script takes an image stack with a nuclear stain and a cytoplasmic stain and makes masks.
%V3 has higher stringencies for nuclear and cytoplasm channel (zeiss has
%better pixel intensity separation

%this script requires other functions written by AH, so load those
%beforehand:
% Eg. addpath('H:/Scripts/Universal_functions','H:/Scripts/Multi_channel_localization');.

%The inputs are:
%1) the image as a matrix
%2) which channel is the nuclear
%3) what the minimum raidus of a nucleus is in pixels
%4) which channel is the cytoplasm (eg. Tuj)

%The function makes 6 masks:
%dilatedmask = cytoplasm mask + nuclear mask
%cytomask = cytoplasm mask
%nuclearmask = nuclear mask
%neuritemask = neurite mask
%backgroundmask = not cytoplasm, nucleus, or neurite
%objectmask = a synthesis of the nuclear, cytoplasm, and neurite masks for
%display


function [nuclearmask,cytomask,dilatedmask,neuritemask,backgroundmask,objectmask,nucleararray] = multichannelmask_v3_3(image,nuclearchannel,nucleusminradius,nucleusstdevs,cytoplasmchannel,cytoplasmstdevs)

[nucleararray, nuclearmask, nuclearnumber, nuclearbinarymask, estimatedmissednuclei, meannucleisize, multinucleicenters] = object_mask_hist_v4(image(:,:,nuclearchannel),nucleusminradius,nucleusstdevs); %could be optimized a bit, but is a reasonable start
membranemask = histmask_v3(image(:,:,cytoplasmchannel),cytoplasmstdevs);% calculates mask using histmask_v3, 2 stdevs
[objectmask, dilatedmask, nuclearmask] = label_dilatecut_v2_2(nuclearmask,membranemask,75);
[neuritemask,neuritearea,proportionalarea] = neuritefilter_v2(image(:,:,cytoplasmchannel),.2);
cytomask = dilatedmask-nuclearmask;
neuritemask = neuritemask-logical(dilatedmask);
objectmask = objectmask + repmat((uint8(neuritemask)*128),[1 1 3]);
backgroundmask = ~logical(nuclearbinarymask+membranemask);

backgroundmask2 = ~bwmorph(nuclearbinarymask+membranemask,'thicken',10);

