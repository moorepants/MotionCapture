from mocap_funcs import derivative
from numpy import load, linspace, save
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
    save('../data/npy/' + run + 'qd.npy', qd)
    qdd = derivative(t[:-1], qd)
    save('../data/npy/' + run + 'qdd.npy', qdd)
    # calculate the frequency spectrums of each data set
    qFreq, qAmp = freq_spectrum(100, q)
    qdFreq, qdAmp = freq_spectrum(100, qd)
    qddFreq, qddAmp = freq_spectrum(100, qdd)
    print run, 'is saved'
