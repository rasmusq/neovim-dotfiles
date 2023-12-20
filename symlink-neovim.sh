#!/bin/bash
script_dir=$(dirname "$(realpath "$0")")

rm -r $HOME"/.config/nvim"
ln -s $script_dir"/nvim" $HOME"/.config/"
