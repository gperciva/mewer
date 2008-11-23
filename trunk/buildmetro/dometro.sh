#!/bin/sh

cp nobeat.gif ../metro/
gifsicle --loop -d 10 beat.gif -d 90 nobeat.gif > ../metro/metro-60.gif
gifsicle --loop -d 10 beat.gif -d 86 nobeat.gif > ../metro/metro-62.5.gif
gifsicle --loop -d 10 beat.gif -d 70 nobeat.gif > ../metro/metro-75.gif
gifsicle --loop -d 10 beat.gif -d 65 nobeat.gif > ../metro/metro-80.gif
gifsicle --loop -d 10 beat.gif -d 54 nobeat.gif > ../metro/metro-93.75.gif
gifsicle --loop -d 10 beat.gif -d 50 nobeat.gif > ../metro/metro-100.gif
gifsicle --loop -d 10 beat.gif -d 40 nobeat.gif > ../metro/metro-120.gif


