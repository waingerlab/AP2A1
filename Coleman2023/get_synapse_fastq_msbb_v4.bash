#!/bin/bash
#SBATCH -c 1                               # Request four cores
#SBATCH -N 1                               # Request one node (if you request more than one core with -c, also using
                                           # -N 1 means all cores will be on the same node)
#SBATCH -t 0-2:00                         # Runtime in D-HH:MM format
#SBATCH -p short                         # Partition to run in
#SBATCH --mem=2G                          # Memory total in MB (for all cores)
#SBATCH -o /home/ah390/logs/%j.out                 # File to which STDOUT will be written, including job ID
#SBATCH -e /home/ah390/logs/%j.err                 # File to which STDERR will be written, including job ID

#download of samples of sorted nuclei

#controls- Braak 0-2 with normal CERAD
library[1]='syn51138154'
library[2]='syn51138058'
library[3]='syn51138061'
library[4]='syn51138071'
library[5]='syn51138105'
library[6]='syn51138127'
library[7]='syn51138130'
library[8]='syn51138139'
library[9]='syn51138148'
library[10]='syn51138204'
library[11]='syn51138111'
library[12]='syn51138124'
library[13]='syn51138136'
library[14]='syn51138157'
library[15]='syn51138165'
library[16]='syn51138185'
library[17]='syn51138827'
library[18]='syn51138472'
library[19]='syn51138486'
library[20]='syn51138501'
library[21]='syn51138597'
library[22]='syn51138706'
library[23]='syn51138715'
library[24]='syn51138782'
library[25]='syn51138813'
library[26]='syn51138876'
library[27]='syn51138636'
library[28]='syn51138690'
library[29]='syn51138771'
library[30]='syn51138838'
library[31]='syn51138860'
library[32]='syn51138871'

#Braak5-6
library[33]='syn51138068'
library[34]='syn51138133'
library[35]='syn51138174'
library[36]='syn51138030'
library[37]='syn51138043'
library[38]='syn51138049'
library[39]='syn51138052'
library[40]='syn51138064'
library[41]='syn51138077'
library[42]='syn51138080'
library[43]='syn51138084'
library[44]='syn51138094'
library[45]='syn51138151'
library[46]='syn51138233'
library[47]='syn51138496'
library[48]='syn51138760'
library[49]='syn51138866'
library[50]='syn51138245'
library[51]='syn51138320'
library[52]='syn51138341'
library[53]='syn51138440'
library[54]='syn51138492'
library[55]='syn51138525'
library[56]='syn51138536'
library[57]='syn51138546'
library[58]='syn51138573'
library[59]='syn51138816'
library[60]='syn51138881'


cd /n/scratch3/users/a/ah390/msbb_neun/ctrl

#download files
for ((n=1;n<=32;n++)); do
	synapse -u ahheld11 -p [redacted] get ${library[$n]}
done


#change directory and download braak6 files
cd /n/scratch3/users/a/ah390/msbb_neun/ad
for ((n=33;n<=60;n++)); do
	synapse -u ahheld11 -p [redacted] get ${library[$n]}
done
