#!/usr/bin/env python3

import sys
import os
from statistics import mean, stdev

def traverse_folders(data, names, level=0):
    if level >= len(names):
        write_aggregate(data)
        return
    else:
        name = names[level]
    for dirname in os.listdir():
        if os.path.isdir(dirname) and dirname.endswith(f'_{name}'):
            data_new = data + [dirname.split('_')[0]]
            
            os.chdir(dirname)
            traverse_folders(data_new, names, level+1)
            os.chdir('..')


def write_aggregate(data):
    with open('output.dat', 'r') as file:
        next(file) # skip headers
        zipped = zip(*(map(float, line.split()[1:]) for line in file.readlines()))

    aggregated = [x for values in zipped for x in (mean(values), stdev(values))]       

    data = '\t'.join(data+aggregated)
    datafile.write(data)


HEADER = '\t'.join((
    'densidad',
    'temperatura',
    'job',
    'potencial mean',
    'potencial std',
    'cinetica mean',
    'cinetica std',
    'total mean',
    'total std',
    'presion mean', 
    'presion std', 
    ))+'\n'

OUTFILE = 'alldata.dat'
DATAFOLDER = 'data'
NAMES = ['dens', 'temp', 'JOB']


with open(OUTFILE, 'w') as datafile:
    datafile.write(HEADER)
    data = []
    os.chdir(DATAFOLDER)
    traverse_folders(data, NAMES)
    os.chdir('..')