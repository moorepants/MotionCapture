import scipy as sp
import numpy as np
import scipy.io.matlab.mio as mio
import matplotlib.pyplot as plt

thirtyData=mio.loadmat("3008.mat")
thirtyQ=thirtyData['q']
thirtyQmax=thirtyQ[:, 1].max()
thirtyQmin=thirtyQ[:, 1].min()
thirtyQrange=np.abs(thirtyQmax-thirtyQmin)
print thirtyQrange
twentyfiveData=mio.loadmat("3009.mat")
twentyfiveQ=twentyfiveData['q']
twentyfiveQmax=twentyfiveQ[:, 1].max()
twentyfiveQmin=twentyfiveQ[:, 1].min()
twentyfiveQrange=np.abs(twentyfiveQmax-twentyfiveQmin)
print twentyfiveQrange
twentyData=mio.loadmat("3010.mat")
twentyQ=twentyData['q']
twentyQmax=twentyQ[:, 1].max()
twentyQmin=twentyQ[:, 1].min()
twentyQrange=np.abs(twentyQmax-twentyQmin)
print twentyQrange
fifteenData=mio.loadmat("3011.mat")
fifteenQ=fifteenData['q']
fifteenQmax=fifteenQ[:, 1].max()
fifteenQmin=fifteenQ[:, 1].min()
fifteenQrange=np.abs(fifteenQmax-fifteenQmin)
print fifteenQrange
tenData=mio.loadmat("3011.mat")
tenQ=tenData['q']
tenQmax=tenQ[:, 1].max()
tenQmin=tenQ[:, 1].min()
tenQrange=np.abs(tenQmax-tenQmin)
print tenQrange
fiveData=mio.loadmat("3012.mat")
fiveQ=fiveData['q']
fiveQmax=fiveQ[:, 1].max()
fiveQmin=fiveQ[:, 1].min()
fiveQrange=np.abs(fiveQmax-fiveQmin)
print fiveQrange
fourData=mio.loadmat("3013.mat")
fourQ=fourData['q']
fourQmax=fourQ[:, 1].max()
fourQmin=fourQ[:, 1].min()
fourQrange=np.abs(fourQmax-fourQmin)
print fourQrange
threeData=mio.loadmat("3014.mat")
threeQ=threeData['q']
threeQmax=threeQ[:, 1].max()
threeQmin=threeQ[:, 1].min()
threeQrange=np.abs(threeQmax-threeQmin)
print threeQrange
twoData=mio.loadmat("3015.mat")
twoQ=twoData['q']
twoQmax=twoQ[:, 1].max()
twoQmin=twoQ[:, 1].min()
twoQrange=np.abs(twoQmax-twoQmin)
print twoQrange
speed=[30,25,20,15,10,5,4,3,2]
latRange=[thirtyQrange,twentyfiveQrange,twentyQrange,fifteenQrange,tenQrange,fiveQrange,fourQrange,threeQrange,twoQrange]
plt.plot(speed,latRange)
plt.show()
