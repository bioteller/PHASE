# PHASE
## Process  of HISAT2 Alignment Special Edition
----
A simple HISAT2 alignment pipeline for Next-gen data generated by sequancing instrument(only Paired-end data in this special Edition). This pipeline is flexible and optimized. It will map and align your fastq reads back to the *reference-index* you given in the configure.set file. And please add more information the config file needs.

### How to install it?
===================== 

The PHASE v1.0 pipeline requirs the following depencies:
   * The <a href="http://ccb.jhu.edu/software/hisat2/index.shtml" target="_blank"> hisat2</a>
Hisat2 >= 2.1.0 is recommanded strongly for I have tested on CentOS7.

To install PHASE v1.0
(```) tar -zvcf hisat_Alignment.tar.gz(```)

### Reference index file
========================

**The hisat2 indexes**. You can download a index file directly from <a href="ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/data" traget="_blank">their FTP server</a>.Please see the <a href="http://ccb.jhu.edu/software/hisat2/manual.shtml#getting-started-with-hisat2" target="_blank">hisat2 manual page</a> online for details about how to create such indexes in your have not one for your tests,

### How to use it correctly?
============================

<td bgcolor="black"><font color="green">$bash hisat2_Alignment.sh configure.set</font></td>

1. Copy and edit the configuration file *'configure.set'* or any other file_name you like.
2. Run the script above, use your configuration file as unique parameter.

### *configure.set* (or other file_name you like)
===========================================
(```)
program_Name=hisat2
data_path=/home/lxb/MNT/nfs2_ND/2018/YAN/ATAC-seq
file_ext=fq.gz
R1_flag=_R1.
R2_flag=_R2.
Thread=5
index=/home/lxb/Applications/indexes/ht2/grcm38_snp_tran/genome_snp_tran
(```)

*<font color="red">NOTE:</font>* DO NOT leave any blanks bwteen "=" and your input. DO NOT change the varients name.
1. *program_Name:* Provide the path of HISAT2 programme
2. *data_path:* Link to clean_data folder. The user need leave at least one folder for samples with input files.
3. *file_ext:* Extension part of clean_data, usually "fastq.gz" but sometimes "fq.gz" so pipeline need this info here.
4. *R1_flag:* Keywords for first mate detection. Typically "_R1" but sometimes "_1".
4. *R2_flag:* Keywords for second mate detection. Typically "_R2" but sometimes "_2".
5. *Thread:* Number of CPU allows per job in this pipeline.
6. *index:* Reference genome prefix used for genome indexes.

### Test Dataset
================

Not applicable
