#!/bin/bash
#SBATCH -c 20                               # Request four cores
#SBATCH -N 1                               # Request one node (if you request more than one core with -c, also using
                                           # -N 1 means all cores will be on the same node)
#SBATCH -t 1-18:00                        # Runtime in D-HH:MM format
#SBATCH -p medium                           # Partition to run in
#SBATCH --mem=50G                          # Memory total in MB (for all cores)
#SBATCH -o /home/ah390/logs/%j.out                 # File to which STDOUT will be written, including job ID
#SBATCH -e /home/ah390/logs/%j.err                 # File to which STDERR will be written, including job ID

module load gcc
module load star
module load samtools

cd /n/scratch/users/a/ah390/tam2019/ALScord
mkdir star_out

for var in reads/*_1.fastq.bz2
do
	filename1=${var}
	filename2=${var:0:17}_2.fastq.bz2
	filename3=${var:6:11}
	mkdir star_out/$filename3
	
	STAR --runThreadN 20 \
	--genomeDir /n/scratch/users/a/ah390/assembly \
	--readFilesIn $filename1 $filename2 \
	--readFilesCommand bunzip2 -c \
	--outFileNamePrefix star_out/$filename3/$filename3 \
	--quantMode GeneCounts \
	--outSAMtype BAM SortedByCoordinate \
	--limitBAMsortRAM 10000000000 \
	--genomeLoad LoadAndKeep
	
	cd star_out/$filename3
	samtools index ${var:0:11}Aligned.sortedByCoord.out.bam
	cd ../..
done


cd /n/scratch/users/a/ah390/tam2019/ALScortex
mkdir star_out

for var in reads/*_1.fastq.bz2
do
	filename1=${var}
	filename2=${var:0:17}_2.fastq.bz2
	filename3=${var:6:11}
	mkdir star_out/$filename3
	
	STAR --runThreadN 20 \
	--genomeDir /n/scratch/users/a/ah390/assembly \
	--readFilesIn $filename1 $filename2 \
	--readFilesCommand bunzip2 -c \
	--outFileNamePrefix star_out/$filename3/$filename3 \
	--quantMode GeneCounts \
	--outSAMtype BAM SortedByCoordinate \
	--limitBAMsortRAM 10000000000 \
	--genomeLoad LoadAndKeep
	
	cd star_out/$filename3
	samtools index ${var:0:11}Aligned.sortedByCoord.out.bam
	cd ../..
done


cd /n/scratch/users/a/ah390/tam2019/CTRLcortex
mkdir star_out

for var in reads/*_1.fastq.bz2
do
	filename1=${var}
	filename2=${var:0:17}_2.fastq.bz2
	filename3=${var:6:11}
	mkdir star_out/$filename3
	
	STAR --runThreadN 20 \
	--genomeDir /n/scratch/users/a/ah390/assembly \
	--readFilesIn $filename1 $filename2 \
	--readFilesCommand bunzip2 -c \
	--outFileNamePrefix star_out/$filename3/$filename3 \
	--quantMode GeneCounts \
	--outSAMtype BAM SortedByCoordinate \
	--limitBAMsortRAM 10000000000 \
	--genomeLoad LoadAndKeep
	
	cd star_out/$filename3
	samtools index ${var:0:11}Aligned.sortedByCoord.out.bam
	cd ../..
done