from mocap_funcs import derivative, freq_spectrum
from numpy import load, linspace, savez
import pickle

# load the run information file
f = open('../data/runInfo.p', 'r')
runInfo = pickle.load(f)
f.close()

for run in runInfo['run']:
    q = load('../data/npy/' + run + 'q.npy')
    l = q.shape[1]
    t = linspace(0, l/100, num=l)
    qd = derivative(t, q)
    qdd = derivative(t[:-1], qd)
    # calculate the frequency spectrums of each data set
    qF, qA = freq_spectrum(100, q)
    qdF, qdA = freq_spectrum(100, qd)
    qddF, qddA = freq_spectrum(100, qdd)
    savez('../data/npy/states/' + run + 'q.npz', q=q, qd=qd, qdd=qdd, qF=qF, qA=qA,
            qdF=qdF, qdA=qdA, qddF=qddF, qddA=qddA)
    print run, 'is saved'
