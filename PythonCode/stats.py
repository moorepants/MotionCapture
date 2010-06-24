import numpy as np
import pickle as p
import scipy.stats as st
import matplotlib.pyplot as plt
from pylab import errorbar
import freqAnal as fa
import string as st

from mocap_funcs import uniquify, findall, freq_spectrum

# load the run information file
f = open('../data/runInfo.p', 'r')
runInfo = p.load(f)
f.close()

# name the states
qName = ['distance to rear wheel contact', 'distance to the rear wheel' +
' contact', 'yaw angle', 'roll angle', 'pitch angle', 'steer angle',
'distance to front wheel contact', 'distance to front wheel contact',
'crank rotation', 'right knee lateral distance', 'left knee lateral distance',
'butt lateral distance', 'lean angle', 'twist angle']

# name the physical quantity, 'l' = length, 'a' = angle
qUnit = ['l', 'l', 'a', 'a', 'a', 'a', 'l', 'l', 'a', 'l', 'l', 'l','a', 'a']

# set to a single run for testing
#runInfo['run'] = ['2002']


# make a sorted list of the unique speeds
v = uniquify(runInfo['speed'])
v.sort()
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
# for each unique speed
for j, speed in enumerate(v):
    matchNum = 0 # start of with zero matches
    # findall all the runs with this speed
    vIndexes = findall(runInfo['speed'], speed)
    NumInSet = 0
    for i, runIndex in enumerate(vIndexes):
        run = runInfo['run'][runIndex]
        print 'Run number', run
        # only do calculations for certain runs
        t1 = run[0] != '1' # don't include Jodi's corrupt data
        t2 = run[1:4] != '001' and run[1:4] != '051' # not static measurements
        t3 = runInfo['condition'][runIndex] == 'normal biking'
        t4 = True #runInfo['bike'][runIndex] == 'stratos' # exclude certain bikes
        t5 = True #runInfo['rider'][runIndex] == 'Jason'
        if t1 and t2  and t3 and t4 and t5: # add the run in if all of the t's are true
            print 'Run number =', run, 'at speed', runInfo['speed'][runIndex], "and it's condition", runInfo['condition'][runIndex]
            NumInSet += 1
            # load the state data:
            qData = np.load('../data/npy/states/' + run + 'q.npz')
            # if it is the first match for this speed
            if matchNum == 0:
                # add q as the first columns in qv
                q = qData['q']
                qd = qData['qd']
                qdd = qData['qdd']
                # make a stats matrix with shape (percents, qs)
                for k, v in qData['fstats'].item().items():
                    print k
                    stats[k] = np.vstack((v['2q'], v['lq'], v['median'], v['uq'], v['98q']))
                # set matchNum so we know it is no longer the first match
                matchNum = 1
            # else it is not the first match
            else:
                # add the current q as a column to qv
                q = np.hstack((q, qData['q']))
                qd = np.hstack((qd, qData['qd']))
                qdd = np.hstack((qdd, qData['qdd']))
                matchNum = 1
            #print 'np.shape(qv) =', np.shape(qv), 'and shape of q =', np.shape(q)
    # file the qv and mfv into a dictionary for that speed
    try: q
    except NameError:
        pass
    else:
        qDict[speed] = q
        qdDict[speed] = qd
        qddDict[speed] = qdd
        nums[speed] = NumInSet
stop
figSize = [(-1.2, -.4), (-1.2, -0.4), (-30, 30), (-10., 10.), (-100., 100.),
        (-75., 75.), (-1., 1.), (0., 0.5), (0., -0.5), (0.0, 0.5), (-0.5, 0.), (-0.05,
        0.05), (-1, 1), (-2, 2)]
# make the speeds into integers for proper sorting
vInt = [int(speed) for speed in v]
vInt.sort()
for i, name in enumerate(qName):
    qI = qName.index(name)
    adjSteer = []
    medFreq = []
    for k in vInt:
        medFreq.append(mfvd[str(k)][qI, :])
        #adjSteer.append(180.0/np.pi*qvd[str(k)][qI, :] - np.mean(qvd[str(k)][qI, :]))
        if qUnit[qI] == 'l':
            adjSteer.append(qvd[str(k)][qI, :])
        elif qUnit[qI] == 'a':
            adjSteer.append(180.0/np.pi*qvd[str(k)][qI, :])

    fig = plt.figure(i)#, figsize=(5, 4))
    fig.canvas.set_window_title(st.capwords(qName[qI]))
    ax1 = fig.add_subplot(111)
    #plt.subplots_adjust(left=0.075, right=0.95, top=0.9, bottom=0.25)
    bp = plt.boxplot(adjSteer, notch=0, sym='', vert=1, whis=1.5)
    plt.setp(bp['boxes'], color='black')
    plt.setp(bp['whiskers'], color='black')
    #plt.setp(bp['fliers'], color='black', marker='+')
    plt.setp(bp['medians'], color='black')
    ax1.yaxis.grid(True, linestyle='-', which='major', color='grey',
                          alpha=0.5)
    labels = [0]
    labels.extend(vInt)
    #plt.yticks(np.linspace(-6, 6, num=13))
    plt.xticks(np.arange(len(v)+1), tuple(labels))
    plt.xlabel('Speed [km/h]')
    if qUnit[qI] == 'l':
        plt.ylabel('Distance [m]')
    elif qUnit[qI] == 'a':
        plt.ylabel('Angle [deg]')
    plt.ylim(figSize[qI])
    plt.title(st.capwords(qName[qI]))
    plt.savefig('../plots/' + st.join(st.split(st.capwords(qName[qI])), '') + 'Nb.png')

    fig = plt.figure(i+14)#, figsize=(5, 4))
    fig.canvas.set_window_title(st.capwords(qName[qI]))
    ax1 = fig.add_subplot(111)
    #plt.subplots_adjust(left=0.075, right=0.95, top=0.9, bottom=0.25)
    bp = plt.boxplot(medFreq, notch=0, sym='', vert=1, whis=1.5)
    plt.setp(bp['boxes'], color='black')
    plt.setp(bp['whiskers'], color='black')
    #plt.setp(bp['fliers'], color='black', marker='+')
    plt.setp(bp['medians'], color='black')
    ax1.yaxis.grid(True, linestyle='-', which='major', color='grey',
                          alpha=0.5)
    labels = [0]
    labels.extend(vInt)
    #plt.yticks(np.linspace(-90, 90, num=13))
    plt.xticks(np.arange(len(v)+1), tuple(labels))
    plt.xlabel('Speed [km/h]')
    plt.ylabel('Frequency [hz]')
    #plt.ylim((-90.0, 90.0))
    plt.title(st.capwords(qName[qI]) + ' Median Frequency')
    plt.savefig('../plots/' + st.join(st.split(st.capwords(qName[qI])), '') + 'NbMf.png')

    plt.show()
