#!/bin/sh

for f in `ls -A1 | grep "^\." | grep -v ".git$"`
do
    rm -rf ~/$f
    echo "ln -s `pwd`/$f ~/$f"
    ln -s `pwd`/$f ~/$f
done

