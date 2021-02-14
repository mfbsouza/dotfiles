#!/usr/bin/python3

from os import getcwd, listdir, environ, symlink, remove
from os.path import isfile, isdir, join
from shutil import rmtree

current_path = getcwd()
current_config_path = join(current_path, '.config')

home_path = environ['HOME']
default_config_path = join(home_path, '.config')

ignore = ['README.md', 'setup.py', '.git', 'scripts']

for element in listdir(current_path):
    if isfile(join(current_path, element)) and element not in ignore:
        try:
            symlink(join(current_path, element), join(home_path, element))
        except FileExistsError:
            remove(join(home_path, element))
            symlink(join(current_path, element), join(home_path, element))


for element in listdir(current_config_path):
    if isdir(join(current_config_path, element)) and element not in ignore:
        try:
            symlink(join(current_config_path, element), join(default_config_path, element))
        except FileExistsError:
            rmtree(join(default_config_path, element))
            symlink(join(current_config_path, element), join(default_config_path, element))


print("finished...")
