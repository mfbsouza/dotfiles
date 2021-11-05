#!/usr/bin/python3

import sys
from os import getcwd, listdir, environ, symlink, remove
from os.path import isfile, isdir, join
from shutil import rmtree

# Variables to the PATH of the ""home"" and "".config"" dir

src_path = getcwd()
src_config_path = join(src_path, '.config')

# Variables to the PATH of the real home and .condig dir

dest_home_path = environ['HOME']
dest_config_path = join(dest_home_path, '.config')

# List of files and folders to be ignored (not installed)

ignore = ['README.md', 'setup.py', 'Code', 'electron-flags.conf']

print(" ----- HOME DIR  ----- ")

for element in listdir(src_path):
        
    target_to_link = join(src_path, element)
    end_target = join(dest_home_path, element)

    if isfile(target_to_link) and element not in ignore:
        try:
            symlink(target_to_link, end_target)
            print("installed: " + str(element))

        except FileExistsError:
            remove(end_target)
            symlink(target_to_link, end_target)
            print("updated: " + str(element))

print(" ----- CONFIG DIR  ----- ")

for element in listdir(src_config_path):

    if element not in ignore:
            
        target_to_link = join(src_config_path, element)
        end_target = join(dest_config_path, element)

        try:
            symlink(target_to_link, end_target)
            print("installed: " + str(element))

        except FileExistsError:
            if isdir(target_to_link):
                rmtree(end_target)
                symlink(target_to_link, end_target)
                print("updated: " + str(element))

            elif isfile(target_to_link):
                remove(end_target)
                symlink(target_to_link, end_target)
                print("updated: " + str(element))

print(" ----- DONE  ----- ")
