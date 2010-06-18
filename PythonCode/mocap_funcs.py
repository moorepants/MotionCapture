from numpy import shape, arange, linspace, abs
from numpy.fft import fft, fftfreq
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
        '''
        Return the next power of 2 for the given number.

        '''
        n = 2
        while n < i: n *= 2
        return n

    T = 1./Fs # sample time
    print 'T =', T
    L = shape(Data)[0] # length of the data
    print 'L =', L
    # calculate the closest power of 2 for the length of the data
    n = nextpow2(L)
    print 'n =', n
    Y = fft(Data, n)
    print 'Y =', Y, shape(Y), type(Y)
    f = fftfreq(n, d=T)
    #f = Fs/2.*linspace(0, 1, n)
    print f, shape(f), type(f)
    freq = f[1:n/2]
    amp = abs(Y[1:n/2])
    power = abs(Y[1:n/2])**2
    return freq, amp, power

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
