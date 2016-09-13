#!/usr/bin/env python

import glob
import os
import sys
import fnmatch
from argparse import ArgumentParser

description = "Howdy"
parser = ArgumentParser(description=description)
parser.add_argument('-d',"--directory",required=True,help="Directory to start the recursive search.")
parser.add_argument('-g',"--glob",required=True,nargs="+",help="A glob pattern for file matching.")

args = parser.parse_args()

directory = args.directory
globs = args.glob

matches = []
for root, dirnames, filenames in os.walk(directory):
	for glob in globs:
		for filename in fnmatch.filter(filenames, glob):
			matches.append(os.path.join(root, filename))

tot_bytes = 0
for i in matches:
	tot_bytes += os.path.getsize(i)

tb = float(tot_bytes)/1024**4
print(tb)
	
