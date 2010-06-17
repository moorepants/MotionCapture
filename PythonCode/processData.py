'''
Prints some max and min values of states

'''
import scipy as sp
import numpy as np
import scipy.io.matlab.mio as mio

print 'Data format: [(long rear contact) (lat rear contact) (yaw)\
 (roll) (rear wheel) (pitch rad) (steer) (front wheel)]\n'
print 'based units meters and radians\n'
twoData=mio.loadmat("3016.mat")
twoQ=twoData['q']
twoQd=np.gradient(twoQ)[0]
twoQdd=np.gradient(twoQd)[0]
twoQmax=np.array([twoQ[:, i].max() for i in range(8)])
twoQmin=np.array([twoQ[:, i].min() for i in range(8)])
twoQrange=np.abs(twoQmax-twoQmin)
print '2 km/h Coordinate Max\n',twoQmax
print '2 km/h Coordinate Min\n',twoQmin
print '2 km/h Coordinate Range\n',twoQrange
twoQdmax=np.array([twoQd[:, i].max() for i in range(8)])
twoQdmin=np.array([twoQd[:, i].min() for i in range(8)])
twoQdrange=np.abs(twoQdmax-twoQdmin)
print '2 km/h Rate Max\n',twoQdmax
print '2 km/h Rate Min\n',twoQdmin
print '2 km/h Rate Range\n',twoQdrange
twoQddmax=np.array([twoQdd[:, i].max() for i in range(8)])
twoQddmin=np.array([twoQdd[:, i].min() for i in range(8)])
twoQddrange=np.abs(twoQddmax-twoQddmin)
print '2 km/h Acceleration Max\n',twoQddmax
print '2 km/h Acceleration Min\n',twoQddmin
print '2 km/h Acceleration Range\n',twoQddrange
thirtyData=mio.loadmat("2008.mat")
thirtyQ=thirtyData['q']
thirtyQd=np.gradient(thirtyQ)[0]
thirtyQdd=np.gradient(thirtyQd)[0]
thirtyQmax=np.array([thirtyQ[:, i].max() for i in range(8)])
thirtyQmin=np.array([thirtyQ[:, i].min() for i in range(8)])
thirtyQrange=np.abs(thirtyQmax-thirtyQmin)
print '30 km/h Coordinate Max\n',thirtyQmax
print '30 km/h Coordinate Min\n',thirtyQmin
print '30 km/h Coordinate Range\n',thirtyQrange
thirtyQdmax=np.array([thirtyQd[:, i].max() for i in range(8)])
thirtyQdmin=np.array([thirtyQd[:, i].min() for i in range(8)])
thirtyQdrange=np.abs(thirtyQdmax-thirtyQdmin)
print '30 km/h Rate Max\n',thirtyQdmax
print '30 km/h Rate Min\n',thirtyQdmin
print '30 km/h Rate Range\n',twoQdrange
thirtyQddmax=np.array([thirtyQdd[:, i].max() for i in range(8)])
thirtyQddmin=np.array([thirtyQdd[:, i].min() for i in range(8)])
thirtyQddrange=np.abs(thirtyQddmax-thirtyQddmin)
print '30 km/h Acceleration Max\n',thirtyQddmax
print '30 km/h Acceleration Min\n',thirtyQddmin
print '30 km/h Acceleration Range\n',thirtyQddrange
