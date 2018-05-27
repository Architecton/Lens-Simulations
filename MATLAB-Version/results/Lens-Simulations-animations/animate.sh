#!/bin/bash

# append transformed image and configuration plot horizontally.
#for i in $(ls a); do
#	convert +append a/${i} b/${i} c/${i}
#done

cd c

# Make gif animation. 
convert -delay 2 -loop 0 *.jpg animation.gif

# Resize gif animation. 
gifsicle --resize-fit 1400x4000 --colors 256 -i animation.gif > animation_transformed.gif
