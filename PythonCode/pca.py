'''
Finds runs that have large gaps.

'''
import os
import re
import scipy.io.matlab.mio as mio
import matplotlib.pyplot as plt
import numpy

def butterworth(dataVector, sampleRate, cutoff):
    """low pass butterworh filter"""
    import math
    # calculate the coefficients
    cutoff2 = cutoff/.802
    deltaX = 1/sampleRate
    Sv = 1/cutoff2/deltaX
    # Sv must be less than 4 for the filter to be valid
    if Sv > 4:
        print 'Filter not valid! Choose a different cut-off frequency'
    # calculate the Butterworth coefficients
    else:
        z = math.pi*cutoff2*deltaX
        z1 = math.sin(z)
        z2 = math.cos(z)
        wc = z1/z2
        a = 2*wc*math.sqrt(0.5)
        b = 0.5*a**2
        c1 = b/(1+a+b)
        c2 = 2*c1
        c3 = c1
        c4 = 2*(1-b)/(1+a+b)
        c5 = (a-b-1)/(1+a+b)
        yForward = []
        for i in range(len(dataVector)):
            if i < 2:
                yForward.append(dataVector[i])
            else:
                yForward.append(c1*dataVector[i]+c2*dataVector[i-1]+c3*dataVector[i-2]+c4*yForward[i-1]+c5*yForward[i-2])
    return yForward

dirs, subdirs, filenames = list(os.walk('.'))[0]

# remove all files from the list except the 2000 and 3000 .mat files
for name in filenames[:]:
    if re.match('[23][0-9][0-9][0-9]\.mat', name) == None:
        filenames.remove(name)

run2002 = {}
mio.loadmat('2002.mat', mdict=run2002)
MaxAllowGap = 1
BadRuns = []
MaxGapSize = []
# search through each key in the dictionary
for k, v in run2002.iteritems():
    # only look at the three original data sets
    if k == 'xori' or k == 'yori' or k == 'zori':
        # walk through each marker
        for marker in v.T:
            # initialize variables
            gap = []
            GapSize = []
            GapChain = False
            # walk through each marker value
            for i in range(MaxAllowGap-1, len(marker)):
                # look for groups of nan's
                if all(numpy.isnan(marker[i-MaxAllowGap+1:i+1])):
                    # make a list of the indices where gaps are detected
                    gap.append(i)
                    # see if the gap is longer than the MaxAllowGap
                    if len(gap) == 1:
                        pass
                    elif gap[-1]-gap[-2] == 1:
                        GapChain = True
                    else:
                        GapChain = False
                    # make a list of gap sizes
                    if GapChain == False:
                        GapSize.append(MaxAllowGap)
                    elif GapChain == True:
                        GapSize.append(GapSize[-1] + 1)
                else:
                    GapSize.append(0)
                # reset the GapChain value after each gap detection
                GapChain = False
            # find the maximum gap size for that marker coordinate
            MaxGapSize.append(max(GapSize))
print 'Maximum gap size =', MaxGapSize
print 'length of maxgapsize =', len(MaxGapSize)
