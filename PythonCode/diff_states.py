from mocap_funcs import derivative, freq_spectrum, curve_area_stats
from numpy import load, linspace, savez
import pickle

# load the run information file
f = open('../data/runInfo.p', 'r')
runInfo = pickle.load(f)
f.close()

fstats = {}

for run in runInfo['run']:
    q = load('../data/npy/states/' + run + 'q.npy')
    l = q.shape[1]
    t = linspace(0, l/100, num=l)
    qd = derivative(t, q)
    qdd = derivative(t[:-1], qd)
    # calculate the frequency spectrums of each data set
    qF, qA = freq_spectrum(100, q)
    qdF, qdA = freq_spectrum(100, qd)
    qddF, qddA = freq_spectrum(100, qdd)
    # calculate the statistics of the frequency spectrums
    fstats['q'] = curve_area_stats(qF, qA)
    fstats['qd'] = curve_area_stats(qdF, qdA)
    fstats['qdd'] = curve_area_stats(qddF, qddA)
    savez('../data/npy/states/' + run + 'q.npz', q=q, qd=qd, qdd=qdd, qF=qF, qA=qA,
            qdF=qdF, qdA=qdA, qddF=qddF, qddA=qddA, fstats=fstats)
    print run, 'is saved'
