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
v.remove('0')
v.remove('12')
v.remove('14')
v.remove('18')
v.remove('16')

# intialize variables
#qBar = np.zeros((68, len(qName)))
#sigmaq = np.zeros_like(qBar)
#runNum = 0
qvd = {}
mfvd = {}
# for each unique speed
for j, speed in enumerate(v):
    matchNum = 0 # start of with zero matches
    # findall all the runs with this speed
    vIndexes = findall(runInfo['speed'], speed)
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
            # load the state data: q(states, time)
            q = np.load('../data/npy/' + run + 'q.npy')
            qd = np.load('../data/npy/' + run + 'qd.npy')
            qdd = np.load('../data/npy/' + run + 'qdd.npy')
            # calculate the frequency spectrums of each data set
            qFreq, qAmp = freq_spectrum(100, q)
            qdFreq, qdAmp = freq_spectrum(100, qd)
            qddFreq, qddAmp = freq_spectrum(100, qdd)

            # if it is the first match for this speed
            if matchNum == 0:
                # add q as the first columns in qv
                qv = q
                # add the median frequencies as the first row in mfv
                mfv = []
                for state in q:
                    mfv.append(fa.med_freq_fft(100, state))
                mfv = np.array(mfv)
                #print 'Shape of mfv', np.shape(mfv)
                # set matchNum so we know it is no longer the first match
                matchNum = 1
            # else it is not the first match
            else:
                # add the current q as a column to qv
                qv = np.append(qv, q, axis=1)
                # calculate the current median frequencies
                mf = []
                for state in q:
                    mf.append(fa.med_freq_fft(100, state))
                mf = np.array(mf)
                #print 'Shape of mf', np.shape(mf)
                # add the column of median freqencies to mfv
                mfv = np.column_stack((mfv, mf))
                #print 'Shape of mfv', np.shape(mfv)
                matchNum = 1
            #print 'np.shape(qv) =', np.shape(qv), 'and shape of q =', np.shape(q)
    # file the qv and mfv into a dictionary for that speed
    try: qv
    except NameError:
        pass
    else:
        qvd[speed] = qv
        mfvd[speed] = mfv
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
