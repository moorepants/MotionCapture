# Filename: fixGaps.py
# Author: Jason K. Moore (moorepants@gmail.com)
# Date: January 20, 2010
# Description: Repairs gap data

import itertools as it
import numpy as np
import matplotlib.pyplot as plt
import os
import re
from scipy.stats import nanmean
import pickle

# load runInfo.p
f = open('../data/runInfo.p', 'r')
runInfo = pickle.load(f)
f.close()

# list what markers make up the fork and frame
forkMarkers = np.array([21, 23, 27, 29])
frameMarkers = np.array([22, 24, 25, 26, 28, 30, 31])
# subtract a one for zero indexing
forkMarkers -= np.ones_like(forkMarkers)
frameMarkers -= np.ones_like(frameMarkers)

# calculate the mean position vectors to the fork and frame markers from the
# static tests
rMeanFork = {}
rMeanFrame = {}
# look through each file name until the static tests are found
for num, run in enumerate(runInfo['run']):
    # if it is a static run...
    if runInfo['condition'][num] == 'static':
        # load the run
        # xyz is an array that is 3 coordinates x 6000 time steps x 31 markers
        xyz = np.load('../data/npy/' + run + '.npy')
        dim = np.shape(xyz)
        # intialize position vectors for markers on the bodies
        rFork = np.zeros((dim[0], dim[1], len(forkMarkers)))
        rFrame = np.zeros((dim[0], dim[1], len(frameMarkers)))
        # intialize a couple of counters
        mFork = 0
        mFrame = 0
        # go through each marker in the data
        for i in range(dim[2]):
            # build the fork vectors
            if i in forkMarkers:
                rFork[:, :, mFork] = xyz[:, :, i]
                mFork += 1
            # build the frame vectors
            elif i in frameMarkers:
                rFrame[:, :, mFrame] = xyz[:, :, i]
                mFrame += 1
            # else skip the marker
            else: pass
        # calculate the mean marker positions neglecting the missing values
        rMeanFork[run] = np.transpose(nanmean(rFork, axis=1))/1000.
        rMeanFrame[run] = np.transpose(nanmean(rFrame, axis=1))/1000.
# load a run and split it into three 2D arrays
xyz = np.load('../data/npy/2064.npy')
x = xyz[0, :, :]
y = xyz[1, :, :]
z = xyz[2, :, :]
# intialize 2D arrays for the fork marker coordinates
forkx = np.ones((len(forkMarkers), x.shape[0]))
forky = np.ones((len(forkMarkers), y.shape[0]))
forkz = np.ones((len(forkMarkers), z.shape[0]))
print "shape of forkx =", np.shape(forkx)
# fill the arrays with the correct data
for i, marker in enumerate(forkMarkers):
    forkx[i] = x[:, marker]
    forky[i] = y[:, marker]
    forkz[i] = z[:, marker]
# create the time vecto
t = np.linspace(0, 59.99, len(x))
# initialize 2D arrays for the reconstructed data
forkxFixed = np.zeros_like(forkx)
forkyFixed = np.zeros_like(forky)
forkzFixed = np.zeros_like(forkz)
# if there are any nan's in the data...
if np.isnan(forkx.sum()) == True:
    # go through each time instance...a row, k indexes time
    for k, row in enumerate(np.transpose(forkx)):
        numBad = 0 # number of nan's per time instance
# test whether it is possible to reconstruct a point that does exist
        #realk = 0
        #if k >= 50 and k <= 70:
        #    realk = row[0]
        #    row[0] = np.nan

        # count how many bad data points are in the the time instance
        for item in row:
            if np.isnan(item) == True:
                numBad = numBad + 1
            else:
                pass
        # if there are less than 3 good data points...
        if len(row) - numBad < 3:
            print "Time sample", k, "is corrupt"
            # set this column the same as the original
            forkxFixed[:, k] = forkx[:, k]
            forkyFixed[:, k] = forky[:, k]
            forkzFixed[:, k] = forkz[:, k]
        # if there are no bad points just save the data
        elif numBad == 0:
            forkxFixed[:, k] = forkx[:, k]
            forkyFixed[:, k] = forky[:, k]
            forkzFixed[:, k] = forkz[:, k]
        # else, fix that shit!
        else:
            print "k =", k
            # make a list of how many markers are on the rigid body
            indexList = range(len(row))
            print "indexList before:", indexList
            # what marker is bad at this time?
            badIndex = []
            for i, item in enumerate(row):
                if np.isnan(item) == True:
                    print row
                    # remember which one is bad
                    badIndex.append(i)
            print "This is the bad index list", badIndex
            # remove the bad data point from the list
            for i in badIndex:
                indexList.remove(i)
            print "indexList after:", indexList
            # create an array of the possible combinations of 3 coordinates
            combs = np.array(list(it.combinations(indexList, 3)))
            print "This is what combs looks like:", combs
            # go through each combination
            for com in combs:
                # create the vectors from the inertial origin to each good data
                r = rMeanFork['2051']
                print "This is the static r\n", r
                # create the vectors from the previous time step for comparison
                rp = np.zeros((len(row), 3))
                for i in indexList:
                    rp[i] = np.array([forkxFixed[i, k-1], forkyFixed[i, k-1],
                        forkzFixed[i, k-1]])
                for i in badIndex:
                    rp[i] = np.array([forkxFixed[i, k-1], forkyFixed[i, k-1],
                        forkzFixed[i, k-1]])
                print "Previous r at k-1 =\n", rp
                # intialize the static local reference fork
                v = np.zeros((3, 3))
                # this is the unit vector from point 1 to 2
                v[0] = (r[com[1]] - r[com[0]])/np.linalg.norm(r[com[1]] - r[com[0]])
                # this is the unit vector from point 1 to 3
                va = (r[com[2]] - r[com[0]])/np.linalg.norm(r[com[2]] - r[com[0]])
                # cross them to get the unit normal vector to the plane made by
                # points 1, 2, and 3
                v[1] = np.cross(v[0], va)
                v[1] = v[1]/np.linalg.norm(v[1])
                # finally cross v1 and v2 to get the third orthogonal component
                v[2] = np.cross(v[0], v[1])
                v[2] = v[2]/np.linalg.norm(v[2])
                # find the measure numbers of the bad marker relative to the
                # new coordinate system
                a = np.zeros_like(row)
                b = np.zeros_like(row)
                c = np.zeros_like(row)
                for value in badIndex:
                    p = r[value] - r[com[0]]
                    a[value] = np.dot(p, v[0])
                    b[value] = np.dot(p, v[1])
                    c[value] = np.dot(p, v[2])
                print "This is a:", a, "and its shape", np.shape(a)
                print "This is b:", b, "and its shape", np.shape(b)
                print "This is c:", c, "and its shape", np.shape(c)
                # create the same position vectors for the current time
                # instance, without r4
                rn = np.zeros((len(row), 3))
                for i in indexList:
                    rn[i] = np.array([forkx[i, k], forky[i, k], forkz[i, k]])
                # create the same reference fork as before but in the current
                # time instance.
                vn = np.zeros((3, 3))
                # this is the unit vector from point 1 to 2
                vn[0] = (rn[com[1]] - rn[com[0]])/np.linalg.norm(rn[com[1]] - rn[com[0]])
                # this is the unit vecomtor from point 1 to 3
                va = (rn[com[2]] - rn[com[0]])/np.linalg.norm(rn[com[2]] - rn[com[0]])
                # cross them to get the unit normal vector to the plane made by
                # points 1, 2, and 3
                vn[1] = np.cross(vn[0], va)
                vn[1] = vn[1]/np.linalg.norm(vn[1])
                # finally cross v1 and v2 to get the third orthogonal component
                vn[2] = np.cross(vn[0], vn[1])
                vn[2] = vn[2]/np.linalg.norm(vn[2])
                print "static v =\n", v
                print "v at k:\n", vn
                print "This percent error in v_k and v_k-1:\n", (vn-v)
                # reconstruct the missing markers
                for i in badIndex:
                    rn[i] = rn[com[0]] + a[i]*vn[0] + b[i]*vn[1] + c[i]*vn[2]
                    print "Reconstructed vector at k =", rn[i]
                    print "Previous vector at k-1 =", rp[i]
                    print "The percent difference =", (rn[i]-rp[i])/rp[i]*100
                forkxFixed[:, k] = rn[:, 0]
                forkyFixed[:, k] = rn[:, 1]
                forkzFixed[:, k] = rn[:, 2]
                #print "realk", realk
                #print "Difference in realK and reconstructed k =", (rn[0, 0]-realk)/realk*100
                #input = raw_input()
for i, marker in enumerate(forkMarkers):
    plt.figure(i)
    plt.subplot(311)
    plt.plot(forkxFixed[i], 'r.', linewidth=4)
    plt.plot(forkx[i], 'k.')
    plt.ylabel('x')
    plt.subplot(312)
    plt.plot(forkyFixed[i], 'r.', linewidth=4)
    plt.plot(forky[i], 'k.')
    plt.ylabel('y')
    plt.subplot(313)
    plt.plot(forkzFixed[i], 'r.', linewidth=4)
    plt.plot(forkz[i], 'k.')
    plt.ylabel('z')
    plt.title('Marker Number: ' + str(marker + 1))

plt.show()
