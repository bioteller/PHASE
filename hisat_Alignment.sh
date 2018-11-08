#! bin/bash

clear
echo 
echo "======================================"
echo "Starting the process of HISAT2 alignment"
echo "Process established by Li, Xiaobo (Tianjin Medical Univ,China)"
echo "2018-11, distribute or modify directly if you'd like to."
echo "Fasten your belt, let us go!"
echo "======================================"
echo
echo "Step 1. HISAT2 Alignment"

m=`awk '{print}' $1`
#echo $m
for i in $m
do
    eval ${i}
done

#echo $program_Name
#echo $data_path
#echo $file_ext
#echo $R1_flag
#echo $R2_flag
NC="-p $Thread"
align_once="-k 1"

#echo $NC
#echo $index


if [ ! -d hisat2_result ];then
    echo "make directory:hisat2_result"
    mkdir hisat2_result
else
    echo "hisat2_result existed. Skip this step"
fi

if [ ! -d log/hisat2 ];then
    echo "make directory:log/hisat2"
    mkdir -p log/hisat2
    log_path="log/hisat2/"
else
    echo "log/hisat2 existed. Skip this step"
    log_path="log/hisat2/"
fi

ls -F ${data_path}|grep '/$'
cd hisat2_result
mkdir `ls -F ${data_path}|grep '/$'`/
pat=`find ${data_path}/ -maxdepth 1 -type d `
cd ..
for i in ${pat[@]}
do
    cur_path=${i##*/}
    #echo ddddddddd $cur_path
    arr=`find $i -maxdepth 1 -name *.$file_ext`
    #echo gg $arr
    k=1
    tmp="_"
    for file_name in $arr
    do
        echo type $cur_path
        #echo ${file_name%%_R*}
        #echo
        if [ $tmp = ${file_name%%${R1_flag}} ] && [ $tmp = ${file_name%%${R2_flag}} ] || [ $k = 0 ];then
            k=1
        elif [ $tmp != ${file_name%%${R1_flag}} ] && [ $tmp != ${file_name%%${R2_flag}} ] || [ $k = 1 ] ;then
            k=0
            file_ns=${file_name%%_R*}
            file_ns=${file_ns##*/}
            mkdir -p hisat2_result/${cur_path}/$file_ns
            mkdir -p log/hisat2/${cur_path}/$file_ns
            echo aligning ${file_ns} ...
            echo -e "\033[31m[Doing]\033[0m ${program_Name} -x ${index} ${NC} ${align_once} -1 ${file_name%%_R*}${R1_flag}${file_ext} -2 ${file_name%%_R*}${R1_flag}${file_ext} --phred33 --reorder 2>${log_path}${cur_path}/${file_ns}/${file_ns}.log | samtools view -bS > hisat2/hisat2_result/${cur_path}/${file_ns}/${file_ns}.bam"
            ${program_Name} -x ${index} ${NC} ${align_once} -1 ${file_name%%_R*}${R1_flag}${file_ext} -2 ${file_name%%_R*}${R1_flag}${file_ext} --phred33 --reorder 2>${log_path}${cur_path}/${file_ns}.log | samtools view -bS > hisat2_result/${cur_path}/${file_ns}/${file_ns}.bam
           echo -e "=================\033[35m[END]\033[0m================="
        elif [ $tmp != ${file_name%%${R1_flag}} ] && [ $tmp != ${file_name%%${R2_flag}} ]|| [ $k = 0 ]; then
            echo "Please check your data! NOT PAIRED"
            exit 1   
            
        fi    
        
    tmp=${file_name%%_R*}
    done
    #for file in `ls $i`
    #do
        #echo $i
        #echo ${file%%_R*}
        #echo 
    #done
done
echo "Finally"
