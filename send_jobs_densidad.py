#!/usr/bin/env python3

import sys
import os
from subprocess import call
from shutil import copy

constants = {
    'dt'      : '0.001',
    'epsilon' : '1.0',
    'sigma'   : '1.0',
    'mass'    : '1.0',
    'gamma'   : '0.5',
    'nwrite'  : '1000',
    'verbose' : 'false',
    }

N           = 200
steps       = 500000
steps_term  = 100000
temperatura = 1.1

densidades = [
    0.001, 0.01, 0.1,
    *[0.1 + 0.7/11*i for i in range(1, 11)],
    0.8, 0.9, 1.0
    ]

data_files = ['input.dat', 'output.dat', 'configuracion.dat', 'movie.vtf']
SKIP_EXISTING = True


def run_job(densidad, steps, temp, N, constants):
    
    L = f'{(N/densidad)**(1/3):.3f}'
    data = f'{N:<10}N (atoms)\n'         + \
           f'{L:<10}L (box size)\n'      + \
           f'{temp:<10.2f}Temperature\n' + \
           f'{steps:<10}nstep\n'

    with open('input.dat','w') as infile:
        infile.write(data)
        for name, value in constants.items():
            infile.write(f'{value:<10}{name}\n')

    call('./dinamica')


def main(args):
    
    if len(args) != 2:
        print('Modo de uso: ./send_jobs.py N_JOBS')
        return 1
    else:
        try:
            njobs = int(args[1])
        except ValueError:
            print('El argumento debe ser un numero entero')
            return 1
        
        for d in densidades:
            tempdir = f'data/{d:.3f}_dens/{temperatura:.2}_temp'
            
            print('*'*30)
            print(f'Corrida a densidad={d:.3f}, T={temperatura:.2}')

            if os.path.exists('configuracion.dat'):
                print('Quitando configuracion.dat para nueva densidad.')
                os.remove('configuracion.dat')

            # corrida de termalizacion
            print("Termalizacion")
            run_job(d, steps_term, temperatura, N, constants)
                
            for job in range(1,njobs+1):
                dirname = f'{tempdir}/{job:02}_JOB'
                if os.path.exists(dirname) and SKIP_EXISTING:
                    print(f'El directorio {tempdir} ya existe, continuando con el siguiente.')
                    continue
                elif not os.path.exists(dirname):
                    os.makedirs(dirname)
                
                print(f'Inciando trabajo {job}')
                # corrida de produccion
                run_job(d, steps, temperatura, N, constants)
                
                for file in data_files:
                    copy(file, dirname)

        print(f'Todos los trabajos finalizados')

        return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv))
