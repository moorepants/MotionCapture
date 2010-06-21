import numpy as np
import matplotlib.pyplot as plt
from mocap_funcs import * 

q = np.load('../data/npy/2002q.npy')
steer = q[5]
f, a, p = freq_spectrum(100, steer)

plt.figure(1)
plt.plot(f, a)

stats = curve_area_stats(f, a)

plt.plot(stats, np.ones_like(stats), '|')

sf = 1000

x = np.linspace(0, 20, num=20*sf)
y = 0.5*np.sin(2*np.pi*50.*x) + 1.*np.sin(2*np.pi*120.*x)

f2, a2 , p2 = freq_spectrum(sf, y)
plt.figure(2)
plt.plot(f2, a2)
plt.show()
