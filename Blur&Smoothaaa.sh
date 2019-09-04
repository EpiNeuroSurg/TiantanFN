for s in `cat bu.txt`
do
H="lh rh"
for h in $H
do
mri_segstats --in ${SUBJECTS_DIR}/$s/surf/"$h".gradient.sm5.mgh --annot $s "$h" aparc --sum ${SUBJECTS_DIR}/$s/stats/"$h".gradient.sm5.stats --snr
done
done
