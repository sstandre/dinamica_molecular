#!/usr/bin/env python3.9

import numpy as np
import matplotlib.pyplot as plt

keys = [
    'N',
    'L',
    'T',
    'dt',
    'nstep',
    'eps',
    'sigma',
    'm',
    'gamma',
    'nwrite',
    'vb',
    ]
g = globals()

with open('input.dat') as f:
    for key, line in zip(keys, f.readlines()):
        g[key] = float(line.split()[0])

steps, Epot, Ecin, Etot = np.loadtxt('output.dat', skiprows=1, unpack=True)

print(f'Energía potencial media: {Epot.mean():.2f}')
print(f'Energía cinética media: {Ecin.mean():.2f}')
print(f'Energía total media: {Etot.mean():.2f}')

print(f'Temperatura input: {T}')
Treal = Ecin.mean()*2/3/N
print(f'Temperatura real: {Treal:.2f}')


plt.plot(steps*dt, Epot, label="Energia potencial")
plt.plot(steps*dt, Ecin, label="Energia cinetica")
plt.plot(steps*dt, Etot, label="Energia total")
plt.xlabel('Tiempo')
plt.legend(loc=(0.1, 0.6))
plt.show()