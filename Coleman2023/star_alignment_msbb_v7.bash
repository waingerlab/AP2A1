#!/bin/bash
#SBATCH -c 20                              # Request four cores
#SBATCH -N 1                               # Request one node (if you request more than one core with -c, also using
                                           # -N 1 means all cores will be on the same node)
#SBATCH -t 0-18:00                        # Runtime in D-HH:MM format
#SBATCH -p medium                           # Partition to run in
#SBATCH --mem=65G                          # Memory total in MB (for all cores)
#SBATCH -o /home/ah390/logs/%j.out                 # File to which STDOUT will be written, including job ID
#SBATCH -e /home/ah390/logs/%j.err                 # File to which STDERR will be written, including job ID

module load gcc/6.2.0
module load star/2.7.3a
module load samtools/1.13

cd /n/scratch3/users/a/ah390/msbb_neun/ctrl
mkdir star_out_gff3

for var in reads/*fastq.gz
do
	filename1=${var}
 	filename2=${var:0:end-10}2.fastq.gz
	filename3=${var:6:6}
	mkdir star_out_gff3/$filename3
	
	STAR --runThreadN 20 \
	--genomeDir /n/data1/hms/hits/albers/lab/Genome_Assemblies_AH/hg38_gencode/assembly100 \
	--readFilesIn $filename1 $filename2 \
 	--readFilesCommand gunzip -c \
	--outFileNamePrefix star_out_gff3/$filename3/$filename3 \
	--quantMode GeneCounts \
	--outSAMtype BAM SortedByCoordinate \
	--limitBAMsortRAM 25000000000 \
 	--sjdbGTFtagExonParentTranscript Parent \
	--genomeLoad LoadAndKeep
	
	cd star_out_gff3/$filename3
	samtools index ${filename3}Aligned.sortedByCoord.out.bam
	cd ../..
done

cd /n/scratch3/users/a/ah390/msbb_neun/ad
mkdir star_out_gff3

for var in reads/*fastq.gz
do
	filename1=${var}
 	filename2=${var:0:end-10}2.fastq.gz
	filename3=${var:6:6}
	mkdir star_out_gff3/$filename3
	
	STAR --runThreadN 20 \
	--genomeDir /n/data1/hms/hits/albers/lab/Genome_Assemblies_AH/hg38_gencode/assembly100 \
	--readFilesIn $filename1 $filename2 \
 	--readFilesCommand gunzip -c \
	--outFileNamePrefix star_out_gff3/$filename3/$filename3 \
	--quantMode GeneCounts \
	--outSAMtype BAM SortedByCoordinate \
	--limitBAMsortRAM 25000000000 \
 	--sjdbGTFtagExonParentTranscript Parent \
	--genomeLoad LoadAndKeep
	
	cd star_out_gff3/$filename3
	samtools index ${filename3}Aligned.sortedByCoord.out.bam
	cd ../..
done
