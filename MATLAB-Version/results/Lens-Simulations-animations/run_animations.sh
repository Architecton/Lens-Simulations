#!/bin/bash


printf "Choose interactive animation to display:\n"
printf "1 - Moving the Second Screen\n"
printf "2 - Rotating and scaling the Second Screen\n"
printf "3 - Scaling the second screen with a factor greater than 1\n"
printf "4 - Scaling the second screen with a factor lesser than 1\n"
printf "5 - Moving the First Screen\n"
printf "6 - Stretching/Squishing the ellipsoid in the x Direction\n"

read option

if (( option == 1 )); then
	gifview -U --title "Moving the Second Screen" "animations_screen/"move_anim.gif
elif (( option == 2 )); then
	gifview -U --title "Rotating and scaling the Second Screen" "animations_screen/"rotation_anim.gif
elif (( option == 3 )); then
	gifview -U --title "Scaling the second screen with a factor greater than 1" "animations_screen/"scaling1_anim.gif
elif (( option == 4 )); then
	gifview -U --title "Scaling the second screen with a factor lesser than 1" "animations_screen/"scaling2_anim.gif
elif (( option == 5 )); then
	gifview -U --title "Moving the First Screen" "animations_screen/"move_first_anim.gif
elif (( option == 6 )); then
	gifview -U --title "Reshaping the Ellipsoid" "animations_lens/"sphere_stretch.gif
fi