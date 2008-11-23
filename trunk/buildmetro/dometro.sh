#!/bin/sh

BUILDDIR=$1

cp nobeat.gif ${BUILDDIR}
gifsicle --loop -d 10 beat.gif -d 90 nobeat.gif > ${BUILDDIR}/metro-60.gif
gifsicle --loop -d 10 beat.gif -d 86 nobeat.gif > ${BUILDDIR}/metro-62.5.gif
gifsicle --loop -d 10 beat.gif -d 70 nobeat.gif > ${BUILDDIR}/metro-75.gif
gifsicle --loop -d 10 beat.gif -d 65 nobeat.gif > ${BUILDDIR}/metro-80.gif
gifsicle --loop -d 10 beat.gif -d 54 nobeat.gif > ${BUILDDIR}/metro-93.75.gif
gifsicle --loop -d 10 beat.gif -d 50 nobeat.gif > ${BUILDDIR}/metro-100.gif
gifsicle --loop -d 10 beat.gif -d 40 nobeat.gif > ${BUILDDIR}/metro-120.gif


