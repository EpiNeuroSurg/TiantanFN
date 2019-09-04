for s in `cat bu.txt`
do
H="lh rh"
for h in $H
do
pctsurfcon --s "$s" --gm-proj-frac 0.5 --neg --b gradient
mris_fwhm --s "$s" --hemi "$h" --cortex --smooth-only --fwhm 5 --i "$s"/surf/"$h".gradient.mgh --o "$s"/surf/"$h".gradient.sm5.mgh
mri_segstats --in ${SUBJECTS_DIR}/$s/surf/"$h".gradient.sm5.mgh --annot $s "$h" aparc --sum ${SUBJECTS_DIR}/$s/stats/"$h".gradient.sm5.stats --snr
done
done

444
