import numpy as np
import matplotlib.pyplot as plt
from mocap_funcs import *
from scipy.integrate import trapz, cumtrapz

# compute the frequency spectrum of example configuration variables
#q = np.load('../data/npy/states/2042q.npy')
#f, a = freq_spectrum(100, q)
#stats = curve_area_stats(f, a)
#for i, variable in enumerate(a.T):
    #legend = ['Frequency Spectrum']
    #plt.figure(i)
    #plt.plot(f, variable)
    #for percent, value in stats.items():
        #plt.plot([value[i], value[i]], [0, np.max(variable)], linewidth=2)
        #legend.append(percent)
    #plt.axis('tight')
    #plt.legend(legend)
    #plt.xlim([0, 5])

# do a test frequency spectrum with know amplitudes
sf = 1000
x = np.linspace(0, 20, num=20*sf)
y = 0.5*np.sin(2*np.pi*50.*x) + 2.*np.sin(2*np.pi*120.*x)
f2, a2 = freq_spectrum(sf, y)
plt.figure()
plt.plot(f2, a2)

plt.show()
