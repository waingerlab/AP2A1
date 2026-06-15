#!/bin/bash
#SBATCH -c 6                               # Request four cores
#SBATCH -N 1                               # Request one node (if you request more than one core with -c, also using
                                           # -N 1 means all cores will be on the same node)
#SBATCH -t 0-11:50                         # Runtime in D-HH:MM format
#SBATCH -p short                           # Partition to run in
#SBATCH --mem=24G                          # Memory total in MB (for all cores)
#SBATCH -o /home/ah390/logs/%j.out                 # File to which STDOUT will be written, including job ID
#SBATCH -e /home/ah390/logs/%j.err                 # File to which STDERR will be written, including job ID

cd /n/scratch/users/a/ah390/tam2019/CTRLcord

module load gcc
module load sratoolkit

library[1]='SRR12165748'
library[2]='SRR12165787'
library[3]='SRR12165844'
library[4]='SRR12165845'
library[5]='SRR12166079'
library[6]='SRR12166274'
library[7]='SRR12166276'
library[8]='SRR12166278'
library[9]='SRR12166349'
library[10]='SRR12166359'
library[11]='SRR12166360'
library[12]='SRR12166365'
library[13]='SRR12166366'
library[14]='SRR12166373'
library[15]='SRR12166374'
library[16]='SRR12166393'
library[17]='SRR12166394'
library[18]='SRR12166423'
library[19]='SRR12166424'
library[20]='SRR12166431'
library[21]='SRR12166433'
library[22]='SRR12166436'
library[23]='SRR12166438'
library[24]='SRR12166496'
library[25]='SRR12166513'
library[26]='SRR12166525'
library[27]='SRR12166552'
library[28]='SRR12166571'
library[29]='SRR12166588'
library[30]='SRR12166754'
library[31]='SRR12166755'
library[32]='SRR12166764'
library[33]='SRR12166765'
library[34]='SRR12166778'
library[35]='SRR12166779'
library[36]='SRR12166788'
library[37]='SRR12166789'
library[38]='SRR12166828'
library[39]='SRR12166829'
library[40]='SRR12167146'
library[41]='SRR12167319'
library[42]='SRR12167320'
library[43]='SRR12167335'
library[44]='SRR12167336'
library[45]='SRR12167390'
library[46]='SRR12167391'
library[47]='SRR12167411'
library[48]='SRR12167426'
library[49]='SRR12167432'
library[50]='SRR12167447'
library[51]='SRR12167486'
library[52]='SRR12167487'
library[53]='SRR12167699'
library[54]='SRR12167716'
library[55]='SRR12167948'
library[56]='SRR12167949'

for ((n=2;n<=56;n++)); do
	prefetch ${library[$n]}
	fasterq-dump ${library[$n]}
	rm -r ${library[$n]}
done

ls *fastq | xargs -n 1 -P 6 bzip2