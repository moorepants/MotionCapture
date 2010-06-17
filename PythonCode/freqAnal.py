'''
Returns the median frequency of a data vector

'''
import numpy as np
import matplotlib.pyplot as plt

#q = np.load('../data/npy/2002q.npy')
#steer = q[5]

def med_freq_fft(Fs, Data):
    def nextpow2(i):
        n = 2
        while n < i: n *= 2
        return n

    def medfreq(f, Y):
        aTot = 0
        for i in range(len(Y) - 1):
            aTot += Y[i]*(f[i+1] - f[i])
        a = 0
        for i in range(len(Y) - 1):
            a += Y[i]*(f[i+1] - f[i])
            if a > aTot/2.:
                break
        return f[i]
    #Fs = 100
    T = 1./Fs
    #print 'T =', T
    L = np.shape(Data)[0]
    #print 'L =', L
    t = np.arange(L)*T
    #print 't =', t
    NFFT = nextpow2(L)
    #print 'NFFT =', NFFT
    Y = np.fft.fft(Data, NFFT)/L
    #print 'Y =', Y, np.shape(Y)
    f = Fs/2.*np.linspace(0, 1, NFFT)
    #print 'f =', f, np.shape(f)
    medFreq = medfreq(f[1:NFFT/2 +1], 2*abs(Y[1:NFFT/2 + 1]))
    #print 'Median Frequency =', medfreq(f[1:NFFT/2 +1], 2*abs(Y[1:NFFT/2 + 1]))
    #plt.figure(0)
    #plt.plot(f[1:NFFT/2 +1], 2*abs(Y[1:NFFT/2 + 1]))
    #plt.figure(1)
    #plt.show()
    return medFreq
