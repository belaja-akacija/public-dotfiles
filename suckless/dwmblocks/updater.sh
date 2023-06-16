#!/bin/bash

yay -Syy
VALUE=$(pacman -Qu | wc -l)
echo $VALUE
exit 0
