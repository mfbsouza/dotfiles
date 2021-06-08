#!/usr/bin/python3

from os import getcwd, listdir, environ, symlink, remove
from os.path import isfile, isdir, join
from shutil import rmtree

# Variables to the PATH of the ""home""" and "".config"" dir

src_path = getcwd()
src_config_path = join(src_path, '.config')

# Variables to the PATH of the real home and .condig dir

dest_home_path = environ['HOME']
dest_config_path = join(dest_home_path, '.config')

# List of files and folder to be ignored (not installed)

ignore = ['README.md', 'setup.py', 'Code', 'chromium-flags.conf']

# main code

print("setting up config files for the home directory")

for element in listdir(src_path):
    
    if isfile(join(src_path, element)) and element not in ignore:
        try:
            symlink(join(src_path, element), join(dest_home_path, element))
            print("installed: " + str(element))
        
        except FileExistsError:
            remove(join(dest_home_path, element))
            symlink(join(src_path, element), join(dest_home_path, element))
            print("updated: " + str(element))

print("setting .config files and folders")

for element in listdir(src_config_path):
    
    if element not in ignore:
        try:
            symlink(join(src_config_path, element), join(dest_config_path, element))
            print("installed: " + str(element))
        
        except FileExistsError:
            if isdir(join(src_config_path, element)):
                rmtree(join(dest_config_path, element))
                symlink(join(src_config_path, element), join(dest_config_path, element))
                print("updated: " + str(element))
            
            elif isfile(join(src_config_path, element)):
                remove(join(dest_config_path, element))
                symlink(join(src_config_path, element), join(dest_config_path, element))
                print("updated: " + str(element))


print("done")
