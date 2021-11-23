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
    ]
g = globals()

with open('input.dat') as f:
    for key, line in zip(keys, f.readlines()):
        g[key] = float(line.split()[0])

steps, Epot, Ecin, Etot, presion= np.loadtxt('output.dat', skiprows=1, unpack=True)

print(f'Energía potencial media: {Epot.mean():.2f} ± {Epot.std():.2f}')
print(f'Energía cinética media: {Ecin.mean():.2f} ± {Ecin.std():.2f}')
print(f'Energía total media: {Etot.mean():.2f} ± {Etot.std():.2f}')

print(f'Densidad: {N/L**3:.3f}')
print(f'Temperatura input: {T}')
Treal = Ecin.mean()*2/3/N
print(f'Temperatura real: {Treal:.2f}')
print(f'Presión media: {presion.mean():.4f} ± {presion.std():.4f}')



plt.plot(steps*dt, Epot, label="Energia potencial")
plt.plot(steps*dt, Ecin, label="Energia cinetica")
plt.plot(steps*dt, Etot, label="Energia total")
plt.xlabel('Tiempo')
plt.legend(loc=(0.1, 0.3))

plt.figure()
plt.plot(steps*dt, presion)
plt.ylim(0, presion.max()*1.1)
plt.show()