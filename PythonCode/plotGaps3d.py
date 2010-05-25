from mpl_toolkits.mplot3d import Axes3D
from matplotlib.collections import PolyCollection
import matplotlib.pyplot as plt
import numpy as np
import os
import re
import scipy.io.matlab.mio as mio
import random as rand
from matplotlib.ticker import FixedLocator, FixedFormatter

# load the sensor names into a dictionary
# open the marker location file
f = open('sensorlocation.txt', 'r')

# initialize the dictionary
markDict = {}
# walk through each line and grab the marker number and marker name
for line in f:
    markNum = re.search(r'\d+', line)
    markName = re.search('\D+', line)
    markDict[int(markNum.group())] = markName.group().strip()
# close the file
f.close()

# make a list of the folder contents
dirs, subdirs, filenames = list(os.walk('.'))[0]

# remove all files from the list except the 2000 and 3000 .mat files
for name in filenames[:]:
        if re.match('\d+\.mat', name) == None:
                    filenames.remove(name)

# make a 3D plot for each run
for name in ['2002.mat']: #filenames:
    runDict = {}
    # load the mat file into a dictionary
    mio.loadmat(name, mdict=runDict)
    # only look at one marker dimension (i.e. 'xori')
    v = np.isnan(runDict['xori'])
    # setup the 3D figure
    fig = plt.figure()
    ax = Axes3D(fig)
    # define the x axis as sample time [0-5999]
    sample = range(np.shape(v)[0])
    # define the z axis as the number of markers [0-30]
    zs = range(np.shape(v)[1])
    verts = []
    # initialize the height of the bars
    height = 0
    # walk through the markers
    for marker in v.T:
        # set the height
        height = height+4
        # make the bars the current height
        marker = height*marker
        # set the endpoints to zero so the polygons close off
        marker[0], marker[-1] = 0, 0
        # build the array of x,y tuples that define the polygon bars
        verts.append(zip(sample, marker))
    # make different rgba color for each marker
    colors = []
    for i in range(len(zs)):
        colors.append((rand.random(), rand.random(), rand.random(), 1.0))
    # make the polygon collection
    poly = PolyCollection(verts, facecolors = colors)
    poly.set_alpha(0.8)
    # plot the polygons
    ax.add_collection3d(poly, zs=zs, zdir='y')
    ax.set_xlim3d(0, 5999)
    ax.set_ylim3d(0, 30)
    ax.set_zlim3d(0, height)
    ax.set_xlabel('Sample #')
    ax.set_ylabel('Marker #')
    ax.set_zlabel('Gap')
    labels = []
    for i in markDict.keys():
        labels.append(markDict[i])
    locator = FixedLocator(range(0, 30))
    ax.w_yaxis.set_major_locator(locator)
    ax.w_yaxis.set_major_formatter(FixedFormatter(labels))
    plt.show()
