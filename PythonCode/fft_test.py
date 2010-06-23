import numpy as np
import matplotlib.pyplot as plt
from mocap_funcs import *
from scipy.integrate import trapz, cumtrapz

q = np.load('../data/npy/2002q.npy')
f, a = freq_spectrum(100, q)

plt.figure(1)
plt.plot(f, a)

area = trapz(a, x=f, axis=0) # area under each curve
cumarea = cumtrapz(a.T, x=f.T)

areas = [cumarea[0]]
areas.extend([cumarea[i] - cumarea[i - 1] for i in range(len(cumarea[1:]))])

stats = curve_area_stats(f, a)

plt.plot([stats, stats], [np.min(a)*np.ones_like(stats), np.max(a)*np.ones_like(stats)])

sf = 1000

x = np.linspace(0, 20, num=20*sf)
y = 0.5*np.sin(2*np.pi*50.*x) + 1.*np.sin(2*np.pi*120.*x)

f2, a2 = freq_spectrum(sf, y)
plt.figure(2)
plt.plot(f2, a2)

plt.figure(3)
test = plt.boxplot(range(10))
test['medians'][0].set_ydata(np.array([stats[2], stats[2]]))
test['boxes'][0].set_ydata(np.array([stats[1], stats[1], stats[3], stats[3],
    stats[1]]))
test['whiskers'][0].set_ydata(np.array([stats[0], stats[1]]))
test['whiskers'][1].set_ydata(np.array([stats[3], stats[4]]))
test['caps'][0].set_ydata(np.array([stats[0], stats[0]]))
test['caps'][1].set_ydata(np.array([stats[4], stats[4]]))
plt.ylim([stats[0] - 1., stats[4] + 1.])
#plt.show()
