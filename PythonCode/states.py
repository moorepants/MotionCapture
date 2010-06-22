import numpy as np
import pickle as p
import matplotlib.pyplot as plt
import string as st

def norm(x):
    n = np.sqrt(np.dot(x, x))
    return n

def uvec(x):
    '''Converts a vector to unit length'''
    u = x/np.sqrt(np.dot(x, x))
    return u

# load the run information file
f = open('../data/runInfo.p', 'r')
runInfo = p.load(f)
f.close()

# load the orignal marker location list
f = open('../data/markLoc.p', 'r')
markLoc = p.load(f)
f.close()

# list the new marker names
newMark = ['front wheel center', 'headtube center', 'handlebar', 'seat stay' +
' center', 'rear wheel center', 'bottom bracket', 'handlebar steer axis',
'rear wheel contact point', 'front wheel contact']

# name the states
qName = ['1 distance to rear wheel contact', '2 distance to the rear wheel' +
' contact', 'yaw angle', 'roll angle', 'pitch angle', 'steer angle',
'1 distance to front wheel contact', '2 distance to front wheel contact',
'crank rotation', 'right knee lateral distance', 'left knee lateral distance',
'butt lateral distance', 'lean angle', 'twist angle']

# add the new marker names to the list
for num, name in enumerate(newMark):
    markLoc['name'].append(name)
    n = num + 32
    markLoc['num'].append(n)

# set the run number to a single value for testing
#runInfo['run'] = ['3017']

for i, run in enumerate(runInfo['run']):
    if int(run) >= 1000:
        # load the data (axis, time, marker)
        mdat = np.load('../data/npy/' + run + 's.npy')
        #print np.isnan(np.sum(mdat)), ", there are some NANS!"
        # create the time vector
        tSteps = mdat.shape[1]
        t = np.linspace(0, 59.99, tSteps)
        # initialize arrays
        q  = np.zeros((len(qName), tSteps)) # generalized coordinates
        p  = np.zeros((tSteps, 3)) # bicycle geometry
        rr = np.zeros((tSteps, 1)) # rear wheel radius
        rf = np.zeros((tSteps, 1)) # front wheel radius

        # set the proper constants depending on which bike was used
        if runInfo['bike'][i] == 'stratos':
            LAMBDA = 0.2967; # steer axis angle
            LCS = 0.44; # chainstay length
            HBB = 0.29; # bottom bracket height
        elif runInfo['bike'][i] == 'browser':
            LAMBDA = 0.4058; # steer axis angle
            LCS = 0.46; # chainstay length
            HBB = 0.295; # bottom bracket height

        # initialize the indice vector used to adjust the crank angle
        indice = []

        for j in range(tSteps): # for each time step do these calculations
            # define the newtonian unit vectors (benchmark ref frame)
            n = np.array([[1, 0, 0], [0, 1, 0], [0, 0, 1]])

            # define the marker reference frame (optotrack frame)
            c = np.array([[1, 0, 0], [0, -1, 0], [0, 0, -1]])
            m = c*n

            # define the original marker positions
            # initialize the position matrix
            r = np.zeros((len(markLoc['num']), 3))
            # for 31 original markers
            for k in range(len(markLoc['num'])-len(newMark)):
                r[k] = mdat[0, j, k]*m[0] + mdat[1, j, k]*m[1] + mdat[2, j, k]*m[2]

            # calculate the midpoint virtual markers
            r[31] = (r[20]+r[26])/2 # front wheel center
            r[32] = (r[21]+r[27])/2 # headtube center
            r[33] = (r[22]+r[28])/2 # handlebar center
            r[34] = (r[23]+r[29])/2 # seat stay center
            r[35] = (r[24]+r[30])/2 # rear wheel center

            # define the normal to a plane through m26, m33 and m36
            a = np.zeros((3, 3))
            b = np.zeros((3, 3))
            d = np.zeros((3, 3))
            e = np.zeros((3, 3))
            b[1] = uvec(np.cross(r[35]-r[25],r[32]-r[25]))
            b[0] = uvec(np.cross(b[1], n[2])) # rear frame heading vector
            b[2] = uvec(np.cross(b[0], b[1]))
            #print "b =\n", b

            a[0] = b[0]
            a[2] = n[2]
            a[1] = uvec(np.cross(a[2],a[0]))
            #print "a =\n", a

            #print "b =\n", b
            #print 'b[2] =', b[2]
            #print 'a[2] =', a[2]
            # use the measured steer axis tilt to find the steer axis,
            # this assumes q6 = 0 (pitch = 0)
            d[0] = uvec(np.cos(LAMBDA)*b[0]-np.sin(LAMBDA)*b[2])
            d[1] = b[1]
            d[2] = uvec(np.cross(d[0],d[1]))
            #print "d =\n", d
            #print "after d"
            #print "b =\n", b
            #print 'b[2] =', b[2]
            #print 'a[2] =', a[2]
            # define a vector from the front left wheel center to the
            # front right wheel center
            e[1] = uvec(r[20] - r[26])
            e[2] = d[2]
            e[0] = uvec(np.cross(e[1], e[2]))
            #print "e =\n", e

            # calculate the rear wheel radius
            rr[j] = -np.dot(r[35], n[2])/np.dot(b[2], n[2])
            #print 'rr =', rr[j]
            # calculate the front wheel radius
            rf[j] = np.dot(-r[31], n[2])/np.sin(np.arccos(np.dot(e[1], n[2])))
            #print 'rf =', rf[j]

            # calculate the bottom bracket virtual marker
            temp = LAMBDA + np.arcsin((rr[j] - HBB)/LCS)
            r_m36_m37 = LCS*np.cos(temp)*d[0] + LCS*np.sin(temp)*d[2]
            r[36] = r[35] + r_m36_m37
            #print 'r[36] =', r[36]

            # define a handlebar marker on the steer axis
            r_m33_m38 = -np.abs(np.dot(r[33]-r[32], e[2]))*e[2]
            r[37] = r[32] + r_m33_m38

            #print 'r[37] =', r[37]
            # define a marker at the rear wheel contact point
            #print 'r[38] =', r[38]
            r[38] = r[35] + rr[j]*b[2]
            #print 'r[38] =', r[38]

            # define a marker at the front wheel contact point
            rfvec = np.cross(np.cross(e[1], n[2]),e[1])
            r_m32_m40 = rf[j] * uvec(rfvec)
            r[39] = r[31] + r_m32_m40
            #print 'r[39] =', r[39]

            # calculate the bicycle geometry
            #p[j, 0] = norm(np.cross(r_m33_m38, r[32] - r[35]))/norm(r_m33_m38)
            #p[j, 1] = norm(np.cross(r_m33_m38, r[32] - r[31]))/norm(r_m33_m38)
            #p[j, 2] = np.dot(e[2], (-p[1]*e[0] - p[0]*d[0] - (r[35] - r[38]))-
            #        r_m32_m40 - (r[38]-r[39]))
            #print 'p =\n', p[j]

            # calculate the states
            # x distance to the rear wheel contact
            q[0, j] = np.dot(n[0], r[38])
            # y distance ot the rear wheel contact
            q[1, j] = np.dot(n[1], r[38])
            # yaw angle
            #print 'a =\n', a
            #print 'n=\n', n
            q[2, j] = np.sign(np.dot(a[0],n[1]))*np.arccos(np.dot(a[0],n[0]))
            # roll angle
            q[3, j] = np.sign(np.dot(b[1],a[2]))*np.arccos(np.dot(b[2], a[2]))
            # pitch angle
            q[4, j] = np.sign(np.dot(d[2],b[0]))*np.arccos(np.dot(b[0],d[0]))
            # steer angle
            q[5, j] = np.sign(np.dot(e[0],d[1]))*np.arccos(np.dot(d[0],e[0]))
            # x distance to the front wheel
            q[6, j] = np.dot(n[0], r[39])
            # y distance to the front wheel
            q[7, j] = np.dot(n[1], r[39])
            # right lateral knee motion
            q[9, j] = np.dot(b[1], (r[2] - r[25]))
            # left lateral knee motion
            q[10, j] = np.dot(b[1], (r[6] - r[25]))
            # lateral butt motion
            q[11, j] = np.dot(b[1], (r[8] - r[25]))
            # lean angle
            r_m9_m11 = r[10] - r[8]
            v = uvec(r_m9_m11 - np.dot(r_m9_m11, b[0])*b[0])
            sign = -np.dot(-v, b[1])
            q[12, j] = sign*np.arccos(np.dot(-v, b[2]))
            # twist angle
            r_m19_m15 = r[14] - r[18]
            tw_proj = uvec(r_m19_m15 - np.dot(r_m19_m15, v)*v)
            g2 = np.cross(b[0], v)
            sign = -np.dot(tw_proj, np.cross(r_m9_m11, g2))
            q[13, j] = sign*np.arccos(np.dot(tw_proj, g2))
            #for marker in range(13):
                #print 'q[' + str(marker) + ', j] =', q[marker, j]
            #input = raw_input()
        np.save('../data/npy/' + run + 'q.npy', q)
        print 'Finished run', run
    else: pass
'''
plt.figure(0)
plt.subplot(211)
plt.plot(t, 100.0*np.transpose(q[0]), '-', label=st.capwords(qName[0]), color='black', linewidth=3)
plt.plot(t, 100.0*np.transpose(q[6]), '-', label=st.capwords(qName[6]), color='grey', linewidth=3)
plt.legend(loc=0)
plt.ylabel('Distance [cm]')
plt.subplot(212)
plt.plot(t, 100.0*np.transpose(q[7]), '--', label=st.capwords(qName[7]), color='grey', linewidth=3)
plt.plot(t, 100.0*np.transpose(q[1]), '--', label=st.capwords(qName[1]), color='black', linewidth=3)
plt.legend(loc=0)
plt.ylabel('Distance [cm]')
plt.xlabel('Time [s]')
plt.xlim((0, 10))
plt.savefig('plots/' + run + 'wheel.pdf')
plt.figure(1)
plt.subplot(311)
plt.plot(t, np.transpose(np.rad2deg(q[2])), '-', label=st.capwords(qName[2]), color='black', linewidth=3)
plt.legend()
plt.ylabel('Angle [deg]')
plt.subplot(312)
plt.plot(t, np.transpose(np.rad2deg(q[3])), '-', label=st.capwords(qName[3]), color='grey', linewidth=3)
plt.legend()
plt.ylabel('Angle [deg]')
plt.subplot(313)
plt.plot(t, np.transpose(np.rad2deg(q[5])), '-', label=st.capwords(qName[5]), color='black', linewidth=3)
plt.legend()
plt.ylabel('Angle [deg]')
plt.xlabel('Time [s]')
plt.xlim((0, 10))
plt.savefig('plots/' + run + 'bAng.pdf')
plt.figure(2)
plt.subplot(311)
plt.plot(t, 100.0*np.transpose(q[9]), '-', label=st.capwords(qName[9]), color='black', linewidth=3)
plt.legend(loc=0)
plt.ylabel('Distance [cm]')
plt.subplot(312)
plt.plot(t, 100.0*np.transpose(q[10]), '-', label=st.capwords(qName[10]), color='grey', linewidth=3)
plt.legend(loc=0)
plt.ylabel('Distance [cm]')
plt.subplot(313)
plt.plot(t, 100.0*np.transpose(q[11]), '--', label=st.capwords(qName[11]), color='black', linewidth=3)
plt.legend(loc = 0)
plt.ylabel('Distance [cm]')
plt.xlabel('Time [s]')
plt.xlim((0, 10))
plt.savefig('plots/' + run + 'rLat.pdf')
plt.figure(3)
plt.plot(t, np.transpose(np.rad2deg(q[12])), '-', label=st.capwords(qName[12]), color='black', linewidth=3)
plt.plot(t, np.transpose(np.rad2deg(q[13])), '-', label=st.capwords(qName[13]), color='grey', linewidth=3)
plt.legend()
plt.ylabel('Angle [deg]')
plt.xlabel('Time [s]')
plt.xlim((0, 10))
plt.savefig('plots/' + run + 'rAng.pdf')
plt.show()
'''
