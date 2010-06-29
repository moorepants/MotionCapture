import numpy as np
import pickle as p
import scipy.stats as st
import matplotlib.pyplot as plt
from pylab import errorbar
import freqAnal as fa
import string as st

from mocap_funcs import uniquify, findall, freq_spectrum, camelcase_nospace

# load the run information file
f = open('../data/runInfo.p', 'r')
runInfo = p.load(f)
f.close()

# name the states
qName = ['longitudinal rear wheel contact',
         'lateral rear wheel contact',
         'yaw',
         'roll',
         'pitch',
         'steer',
         'longitudinal front wheel contact',
         'lateral front wheel contact',
         'crank rotation',
         'right knee lateral',
         'left knee lateral',
         'butt lateral',
         'lean',
         'twist']

# name the physical quantity, 'len' = length, 'ang' = angle
qUnit = ['length', 'length', 'angle', 'angle', 'angle', 'angle', 'length', 'length', 'angle', 'length', 'length', 'length','angle', 'angle']

# set to a single run for testing
#runInfo['run'] = ['2002']


# make a sorted list of the unique speeds
UniqueSpeeds = uniquify(runInfo['speed'])
UniqueSpeeds.sort()
# remove the no hands speeds
#v.remove('0')
#v.remove('12')
#v.remove('14')
#v.remove('18')
#v.remove('16')

# intialize variables
qDict = {}
qdDict = {}
qddDict = {}
nums = {}
stats = {}
condition = 'towing + nohands'
# for each unique speed
for j, speed in enumerate(UniqueSpeeds):
    fstats = {}
    matchNum = 0 # start of with zero matches
    # findall all the runs with this speed
    vIndexes = findall(runInfo['speed'], speed)
    NumInSet = 0
    for i, runIndex in enumerate(vIndexes):
        # there is one bad data set for 10 mph, no hands riding
        if condition == 'nohands' and speed == '10':
            break
        run = runInfo['run'][runIndex]
        print 'Run number', run
        # only do calculations for certain runs
        t1 = run[0] != '1' # don't include Jodi's corrupt data
        t2 = run[1:4] != '001' and run[1:4] != '051' # not static measurements
        t3 = runInfo['condition'][runIndex] == condition
        t4 = True #runInfo['bike'][runIndex] == 'stratos' # exclude certain bikes
        t5 = True #runInfo['rider'][runIndex] == 'Jason'
        if t1 and t2  and t3 and t4 and t5: # add the run in if all of the t's are true
            print 'Run number =', run, 'at speed', runInfo['speed'][runIndex], "and it's condition", runInfo['condition'][runIndex]
            if speed == '10':
                print 'this one is the bad one'
            NumInSet += 1
            # load the state data:
            qData = np.load('../data/npy/states/' + run + 'q.npz')
            # if it is the first match for this speed
            if matchNum == 0:
                # add q as the first columns in qv
                q = qData['q']
                qd = qData['qd']
                qdd = qData['qdd']
                # make a stats matrix with shape (percents, q's)
                for k, v in qData['fstats'].item().items():
                    # fstats[k] is (5,14), k is ['q', 'qd', 'qdd']
                    fstats[k] = np.vstack((v['2p'], v['lq'], v['median'], v['uq'], v['98p']))
                # set matchNum so we know it is no longer the first match
                matchNum = 1
            # else it is not the first match
            else:
                # add the current q as a column to q
                q = np.hstack((q, qData['q']))
                qd = np.hstack((qd, qData['qd']))
                qdd = np.hstack((qdd, qData['qdd']))
                for k, v in qData['fstats'].item().items():
                    fstats[k] = np.dstack((fstats[k], np.vstack((v['2p'],
                        v['lq'], v['median'], v['uq'], v['98p']))))
                matchNum = 1
    # take the average of the computed frequency stats
    for k, v in fstats.items():
        try:
            fstats[k] = np.mean(v, axis=2)
        except: # except if there is only one run
            pass
    if NumInSet == 0:
        pass
    else:
        qDict[speed] = q
        qdDict[speed] = qd
        qddDict[speed] = qdd
        nums[speed] = NumInSet
        stats[speed] = fstats
# make the speeds into integers for proper sorting
vInt = [int(speed) for speed in nums.keys()]
vInt.sort()
lenYlabels = {'q':'Distance [m]', 'qd':'Rate [m/s]', 'qdd':'Acceleration [$m/s^2$]'}
angYlabels = {'q':'Angle [deg]', 'qd':'Angular Rate [deg/s]', 'qdd':'AngularAcceleration [deg/$s^2$]'}
# for each of the states
for i, name in enumerate(qName):
    qBox = {'q':[], 'qd':[], 'qdd':[]}
    for k in vInt:
        qBox['q'].append(qDict[str(k)][i, :])
        qBox['qd'].append(qdDict[str(k)][i, :])
        qBox['qdd'].append(qddDict[str(k)][i, :])
    for k in qBox.keys():
        fig = plt.figure()
        ax1 = fig.add_subplot(111)
        if qUnit[i] == 'length':
            bp = plt.boxplot(qBox[k], notch=0, sym='', vert=1, whis=1.5, positions=vInt)
            plt.ylabel(lenYlabels[k])
        elif qUnit[i] == 'angle':
            bp = plt.boxplot([180./np.pi*s for s in qBox[k]], notch=0, sym='', vert=1, whis=1.5, positions=vInt)
            plt.ylabel(angYlabels[k])
        else:
            print "why isn't there a unit"
        plt.setp(bp['boxes'], color='black')
        plt.setp(bp['whiskers'], color='black')
        plt.setp(bp['medians'], color='black')
        ax1.yaxis.grid(True, linestyle='-', which='major', color='grey',
                              alpha=0.5)
        plt.xlabel('Speed [km/h]')
        # make correct titles
        if k == 'q' and qUnit[i] == 'angle':
            plt.title(st.capwords(condition + ' ' + qName[i] + ' ' + qUnit[i]))
        elif k == 'q' and qUnit[i] == 'length':
            plt.title(st.capwords(condition + ' ' + qName[i] + ' ' + 'Distance'))
        elif k == 'qd' and qUnit[i] == 'angle':
            plt.title(st.capwords(condition + ' ' + qName[i] + ' ' + 'Angular Rate'))
        elif k == 'qd' and qUnit[i] == 'length':
            plt.title(st.capwords(condition + ' ' + qName[i] + ' ' + 'Speed'))
        elif k == 'qdd' and qUnit[i] == 'angle':
            plt.title(st.capwords(condition + ' ' + qName[i] + ' ' + 'Angular Acceleration'))
        elif k == 'qdd' and qUnit[i] == 'length':
            plt.title(st.capwords(condition + ' ' + qName[i] + ' ' + 'Acceleration'))
        directory = '../plots/' + camelcase_nospace(condition) + '/' + k + '/'
        filename = camelcase_nospace(condition) + camelcase_nospace(qName[i]) + k
        extension = '.png'
        plt.savefig(directory + filename + extension)
        # now modify the graph such that it reads the frequency spectrum
        for j, sp in enumerate(vInt): # for each speed in the current graph
            g = stats[str(sp)][k][:, i]
            bp['boxes'][j].set_ydata(np.array([g[1], g[1], g[3], g[3], g[1]]))
            bp['medians'][j].set_ydata(np.array([g[2], g[2]]))
            bp['whiskers'][j*2].set_ydata(np.array([g[0], g[1]]))
            bp['whiskers'][j*2+1].set_ydata(np.array([g[3], g[4]]))
            bp['caps'][j*2].set_ydata(np.array([g[0], g[0]]))
            bp['caps'][j*2+1].set_ydata(np.array([g[4], g[4]]))
        # now fix the titles and labels
        plt.ylabel('Frequency [Hz]')
        plt.ylim(0., 50.)
        plt.gca().set_title(plt.gca().get_title() + ' Frequency Spectrum')
        plt.savefig(directory + filename + 'Freq' + extension)
#plt.show()
