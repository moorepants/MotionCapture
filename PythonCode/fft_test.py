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
plt.show()
