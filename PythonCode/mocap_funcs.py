from numpy import shape, arange, linspace
from numpy.fft import fft
'''
Functions for bicycle motion capture analysis.

'''
def uniquify(seq):
    # Not order preserving
    keys = {}
    for e in seq:
        keys[e] = 1
    return keys.keys()

def findall(L, value):
    '''
    Finds all the indices of a value in a list.

    Parameters:
    -----------
    L : list
    value : the search value

    Returns:
    --------
    a : list of indices that match value

    '''
    a = []
    for i in range(len(L)):
        if L[i] == value:
            a.append(i)
    return a

def freq_spectrum(Fs, Data):
    '''
    Return the frequency spectrum of a data set.

    Parameters:
    -----------

    Fs : sampling frequency
    Data : the time history vector

    Returns:
    --------

    freq : 
    amp : 

    '''
    def nextpow2(i):
        n = 2
        while n < i: n *= 2
        return n

    #Fs = 100
    T = 1./Fs
    print 'T =', T
    L = shape(Data)[0]
    print 'L =', L
    t = arange(L)*T
    print 't =', t
    NFFT = nextpow2(L)
    print 'NFFT =', NFFT
    Y = fft(Data, NFFT)/L
    print 'Y =', Y, shape(Y), type(Y)
    f = Fs/2.*linspace(0, 1, NFFT)
    print f, shape(f), type(f)
    freq = f[1:NFFT/2 + 1]
    amp = 2*abs(Y[1:NFFT/2 + 1])
    return freq, amp

def medfreq(f, Y):
    '''
    Returns the median frequency

    '''
    aTot = 0
    for i in range(len(Y) - 1):
        aTot += Y[i]*(f[i+1] - f[i])
    a = 0
    for i in range(len(Y) - 1):
        a += Y[i]*(f[i+1] - f[i])
        if a > aTot/2.:
            break
    return f[i]
