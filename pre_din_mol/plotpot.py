import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt('potencial.dat')

start = len(data)-len(data[data<0])

print(start)
print(data[-1])
plt.plot(data[start:])
plt.show()