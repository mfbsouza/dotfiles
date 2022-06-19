#!/usr/bin/python3

import sys
from os import getcwd, listdir, environ, symlink, remove
from os.path import isfile, isdir, join
from shutil import rmtree


src_path = getcwd()
src_config_path = join(src_path, '.config')

dest_home_path = environ['HOME']
dest_config_path = join(dest_home_path, '.config')

# List of files and folders to be ignored (not installed)

ignore_list = ['README.md', 'setup.py', 'chromium-flags.conf', 'mpv', '.bashrc']

print(" ----- HOME DIR  ----- ")

for element in listdir(src_path):
        
    target_to_link 	= join(src_path, element)
    end_target 		= join(dest_home_path, element)

    if isfile(target_to_link) and element not in ignore_list:
        try:
            symlink(target_to_link, end_target)
            print("installed: " + str(element))

        except FileExistsError:
            remove(end_target)
            symlink(target_to_link, end_target)
            print("updated: " + str(element))

print(" ----- CONFIG DIR  ----- ")

for element in listdir(src_config_path):

    if element not in ignore_list:
            
        target_to_link 	= join(src_config_path, element)
        end_target 		= join(dest_config_path, element)

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

