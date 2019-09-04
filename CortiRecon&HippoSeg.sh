ls images/ >list.txt

bash
export FREESURFER_HOME=/usr/local/freesurfer_de
source $FREESURFER_HOME/SetUpFreeSurfer.sh
SUBJECTS_DIR=$PWD

################################################## Cortical Construction
for s in `cat list.txt`;
do
recon-all -s $s -i ../images/$s/anat.nii -FLAIR ../images/$s/flair.nii -FLAIRpial -all -parallel -openmp 4
done

################################################## Hippocampal Segmentation
for s in `cat list.txt`; do
segmentHA_T1.sh $s
done

for s in `cat list.txt`; do
freeview -v $s/mri/nu.mgz -v $s/mri/lh.hippoAmygLabels-T1.v21.mgz:colormap=lut -v $s/mri/rh.hippoAmygLabels-T1.v21.mgz:colormap=lut
done
quantifyHAsubregions.sh hippoSf T1 vol_hippo.csv
quantifyHAsubregions.sh amygNuc T1 vol_amy.csv

aaa
