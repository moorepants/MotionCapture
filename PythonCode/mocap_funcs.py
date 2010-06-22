from numpy import shape, arange, linspace, abs, diff
from numpy.fft import fft, fftfreq
from scipy.integrate import trapz, cumtrapz
'''
Functions for bicycle motion capture analysis.

'''
def derivative(x, y):
    return diff(y)/diff(x)

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
    Y = fft(Data, n) # the matlab thing divides this by L
    print 'Y =', Y, shape(Y), type(Y)
    f = fftfreq(n, d=T)
    #f = Fs/2.*linspace(0, 1, n)
    print f, shape(f), type(f)
    freq = f[1:n/2]
    amp = abs(Y[1:n/2]) # mulitply by 2??
    power = abs(Y[1:n/2])**2
    return freq, amp, power

def curve_area_stats(x, y):
    '''
    Return the box plot stats of a curve based on area.

    Parameters:
    -----------
    x : ndarray
        The x values
    y : ndarray
        The y values

    Returns:
    --------
    median :
        The x value corresponding to 0.5*area
    lq : lower quartile
    uq : upper quartile

    '''
    area = trapz(y, x=x)
    percents = [0.02*area, 0.25*area, 0.5*area, 0.75*area, 0.98*area]
    CumArea = cumtrapz(y, x=x)
    flags = [False for flag in range(5)]
    xstats = []
    for i, val in enumerate(CumArea):
        if val > percents[0] and flags[0] == False:
            xstats.append(i)
            flags[0] = True
        elif val > percents[1] and flags[1] == False:
            xstats.append(i)
            flags[1] = True
        elif val > percents[2] and flags[2] == False:
            xstats.append(i)
            flags[2] = True
        elif val > percents[3] and flags[3] == False:
            xstats.append(i)
            flags[3] = True
        elif val > percents[4] and flags[4] == False:
            xstats.append(i)
            flags[4] = True
    return x[xstats]
