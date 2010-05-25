# Filename: mat2npy.py
# Author: Jason K. Moore (moorepants@gmail.com)
# Creation Date: Friday, January 15, 2010
# Description: This script creates compressed numpy files (*.npy) from the
# orignal matlab data files (*.mat) of the motion capture data for three
# different riders. The *.npy files contain a single array for each run that
# is (18000, 31) where the x, y and z coordinate matrices are stacked. The
# files are gzipped into three tar archives (*.tar.gz). A runInfo.txt file is
# also created with the details of each run.
# Updates:
# 04/02/10: Added support for static measurment files.
import os
import re
import tarfile
import numpy as np
import scipy.io.matlab.mio as mio

# make a list of the folder contents
dirs, subdirs, filenames = list(os.walk('../data/mat'))[0]

# remove all files from the list except the 1000, 2000 and 3000 .mat files
for name in filenames[:]:
    if re.match('\d+\.mat', name) == None:
        filenames.remove(name)
filenames.sort()

# list the note names and initialize
notes = ['run', 'rider', 'bike', 'condition', 'speed', 'gear']
runInfo = {}
firstLine = ''

# make and write the header line of the runInfo file
for item in notes:
    runInfo[item] = []
    firstLine = firstLine + item + ','
firstLine = firstLine[0:-1] + '\n'
f = open('../data/runInfo.txt', 'w')
f.write(firstLine)
f.close()

# open runInfo.txt for appending
f = open('../data/runInfo.txt', 'a')

# make a numpy file for every matlab file
for name in filenames[:]:
    runDict = {'rider':''}
    # load the matlab data file into a dictionary
    mio.loadmat(name, mdict=runDict)
    if name[2:4] == '01' or name[2:4] == '51':
        x = runDict['x']
        y = runDict['y']
        z = runDict['z']
        # make the splined data for the static runs zero for now
        xs = np.zeros((60, 31))
        ys = np.zeros((60, 31))
        zs = np.zeros((60, 31))
        q = np.zeros((10, 60))
        runDict['gear'] = runDict['gearing'] = np.array([[0]])
        runDict['speed'] = runDict['V'] = np.array([[0]])
        runDict['condition'] = np.array([u'static'])
        if name[2:4] == '01':
            runDict['bike'] = np.array([u'stratos'])
        elif name[2:4] == '51':
            runDict['bike'] = np.array([u'browser'])
    else:
        x = runDict['xori']
        y = runDict['yori']
        z = runDict['zori']
        xs = runDict['x']
        ys = runDict['y']
        zs = runDict['z']
    # name the rider depending on the filename
    if name[0] == '1':
        runDict['rider'] = 'Jodi'
        runDict['gearing'] = runDict['gear']
    elif name[0] == '2':
        runDict['rider'] = 'Victor'
        runDict['gear'] = runDict['gearing']
    else:
        runDict['rider'] = 'Jason'
        runDict['gear'] = runDict['gearing']
    # change V to speed
    runDict['speed'] = runDict['V']
    del runDict['V']
    xyz = np.array([x, y, z])
    xyzs = np.array([xs, ys, zs])
    # save the array as a binary numpy file
    np.save('../data/npy/' + name[0:-4] + '.npy', xyz)
    np.save('../data/npy/' + name[0:-4] + 's.npy', xyzs)
    # make the next line in the runInfo file and append it to the file
    line = ''
    for item in notes:
        if item == 'run':
            runInfo[item].append(name[0:-4])
        elif item == 'speed' or item == 'gear':
            runInfo[item].append(str(runDict[item][0,0]))
        elif item == 'rider':
            runInfo[item].append(runDict[item])
        else:
            runInfo[item].append(runDict[item][0].encode("ascii"))
        line = line + runInfo[item][-1] + ','
    line = line[0:-1] + '\n'
    f.write(line)
f.close()

# compress the data files into three in tar archives
jodi = tarfile.open('../data/npy/jodi.tar.gz', "w:gz")
victor = tarfile.open('../data/npy/victor.tar.gz', "w:gz")
jason = tarfile.open('../data/npy/jason.tar.gz', "w:gz")
for name in filenames[:]:
    if re.match('1\d+\.mat', name) != None:
        jodi.add('../data/npy/' + name[0:-4] + '.npy')
    elif re.match('2\d+\.mat', name) != None:
        victor.add('../data/npy/' + name[0:-4] + '.npy')
    else:
        jason.add('../data/npy/' + name[0:-4] + '.npy')
jodi.close()
victor.close()
jason.close()
