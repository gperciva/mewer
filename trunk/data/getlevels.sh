#!/bin/sh

BEGINNER="quarter00 eighth01 sixteen01 sixteen02 rest01 long01"
MODERATE="triplet01 triplet02 triplet03 rest02"
# MODERATE="triplet01 triplet02 triplet03 rest02 long02"

rm -rf ?
rm -f ?.txt

i=0
for lvl in $BEGINNER $MODERATE
do
  cp header.ly /tmp/rhythms/
  pushd /tmp/rhythms/$lvl
  for ly in *.ly
  do
    cat /tmp/rhythms/header.ly $ly > $ly-compile
    #lilypond -dpreview -dresolution=100 $ly-compile
    lilypond -dpreview $ly-compile
    lybase=`basename -s .ly $ly`
    mv $lybase.preview.png $lybase.png
  done
  popd
  mkdir $i
  cp /tmp/rhythms/$lvl/*.png $i
  cp /tmp/rhythms/$lvl/*.txt $i
  pushd $i
  cat *.txt > ../$i.txt
  rm *.txt
  convert $i/0001.png -scale 70% $i.png
  popd
  i=$((++i))
done

cp -r ? ~/Sites/data/

