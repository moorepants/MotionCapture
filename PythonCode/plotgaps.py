# This script makes plots showing the missing markers during each run.
# Filename: plotgaps.py
# Author: Jason K. Moore (moorepants@gmail.com)
# Date: Tuesday, January 12, 2010
import os
import re
import random as rand
import numpy as np
from matplotlib.pylab import *
import scipy.io.matlab.mio as mio

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

# make a list of marker labels
labels = []
for i in markDict.keys():
    labels.append(markDict[i])

# make a list of the folder contents
dirs, subdirs, filenames = list(os.walk('.'))[0]

# remove all files from the list except the 1000, 2000 and 3000 .mat files
for name in filenames[:]:
    if re.match('\d+\.mat', name) == None:
        filenames.remove(name)

def plot_gaps(name, axis):
    """Takes the file name and coordinate axis and plots the marker gaps"""
    runDict = {}
    # load the matlab data file into a dictionary
    mio.loadmat(name, mdict=runDict)
    # name the rider depending on the filename
    if name[0] == '1':
        rider = 'Jodi'
        runDict['gearing']=runDict['gear']
    elif name[0] == '2':
        rider = 'Victor'
    else:
        rider = 'Jason'
    speed = np.average(runDict['V'])
    # only look at one marker dimension (i.e. 'xori')
    v = np.isnan(runDict[axis])
    # set the figure size
    fig = figure(1, figsize=(15., 9.))
    matshow(v.T, fignum=1, aspect='auto', cmap=cm.gray)
    yticks(range(np.shape(v)[1]), labels)
    xlabel('Sample Number')
    ylabel('Marker gaps in the {axis} coordinate'.format(axis=axis[0]))
    title(('File: {name}, {rider} riding the {bike} at {speed} km/h while' +
            ' {condition} in gear {gear}').format(name=name, rider=rider, bike=runDict['bike'][0],
                speed=str(speed), condition=runDict['condition'][0],
                gear=runDict['gearing'][0][0]))
    fig.savefig('gapImages/'+name[0:-4]+axis[0]+'.png')
    show()

# set the flag for the first plot
firstPlot = True
while axis != 'x' or axis != 'y' or axis != 'z':
    axis = raw_input("Enter 'x', 'y' or 'z' to view the coordinates for the" +
        " respective axis\n")
    if axis == 'x' or axis == 'y' or axis == 'z':
        axis = axis + 'ori'
        break
    else:
        pass

# run the program until the user enters 'q'
while input != 'q':
    input = raw_input("Enter the desired run number, 'n' to plot the next run, 'q' to quit\n")
    # if 'n' is the input, plot the next run in the sequence, except if it is
    # the first plot
    if input == 'n':
        if firstPlot == True:
            name = filenames[0]
            firstPlot = False
        else:
            name = filenames[filenames.index(name) + 1]
    # else if a run number is entered, plot it and set the first plot flag to
    # false
    else:
        name = input + '.mat'
        firstPlot = False
    # if the input is q skip plotting
    if input == 'q':
        pass
    # otherwise plot, but make sure the run number is a valid number
    else:
        if name in filenames:
            plot_gaps(name, axis)
        else:
            print 'Not a valid file name, choose another number'
