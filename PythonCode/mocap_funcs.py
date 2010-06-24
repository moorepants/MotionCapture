from numpy import shape, arange, linspace, abs, diff, array
from numpy.fft import fft, fftfreq
from scipy.integrate import trapz, cumtrapz
'''
Functions for bicycle motion capture analysis.

'''
def derivative(x, y):
    '''
    Return the derivative of y wrt to x.

    Parameters:
    -----------
    x : ndarray, shape(n,)
    y : ndarray, shape(n,)

    Returns:
    --------
    dydx : ndarray, shape(n-1,)

    '''
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

    Fs : int
        sampling frequency
    Data : ndarray, shape (n,m)
        the time history vector
        n is the number of variables
        m is the number of time steps

    Returns:
    --------

    freq : ndarray, shape (p,)
        the frequencies where p a power of 2 close to m
    amp : ndarray, shape (p,n)

    '''
    def nextpow2(i):
        '''
        Return the next power of 2 for the given number.

        '''
        n = 2
        while n < i: n *= 2
        return n

    T = 1./Fs # sample time
    #print 'T =', T
    try:
        L = Data.shape[1] # length of Data if (n, m)
    except:
        L = Data.shape[0] # length of Data if (n,)
    #print 'L =', L
    # calculate the closest power of 2 for the length of the data
    n = nextpow2(L)
    #print 'n =', n
    Y = fft(Data, n) # the matlab thing divides this by L
    #print 'Y =', Y, Y.shape, type(Y)
    f = fftfreq(n, d=T)
    #f = Fs/2.*linspace(0, 1, n)
    #print 'f =', f, f.shape, type(f)
    freq = f[1:n/2]
    try:
        amp = abs(Y[:, 1:n/2]).T # mulitply by 2??
        #power = abs(Y[:, 1:n/2])**2
    except:
        amp = abs(Y[1:n/2]) # mulitply by 2??
        #power = abs(Y[1:n/2])**2
    return freq, amp

def curve_area_stats(x, y):
    '''
    Return the box plot stats of a curve based on area.

    Parameters:
    -----------
    x : ndarray, shape (n,)
        The x values
    y : ndarray, shape (n,m)
        The y values
        n are the time steps
        m are the various curves

    Returns:
    --------
    A dictionary containing:
    median : ndarray, shape (m,)
        The x value corresponding to 0.5*area under the curve
    lq : ndarray, shape (m,)
        lower quartile
    uq : ndarray, shape (m,)
        upper quartile
    98q : ndarray, shape (m,)
        98th percentile
    2q : ndarray, shape (m,)
        2nd percentile

    '''
    area = trapz(y, x=x, axis=0) # shape (m,)
    percents = array([0.02*area, 0.25*area, 0.5*area, 0.75*area, 0.98*area]) # shape (5,m)
    print "Shape of percents: ", percents.shape
    CumArea = cumtrapz(y.T, x=x.T) # shape(m,n)
    print CumArea.shape
    xstats = {'2q':[], 'lq':[], 'median':[], 'uq':[], '98q':[]}
    for j, curve in enumerate(CumArea):
        print j
        print curve
        flags = [False for flag in range(5)]
        for i, val in enumerate(curve):
            if val > percents[0][j] and flags[0] == False:
                print 'got the first'
                xstats['2q'].append(x[i])
                print xstats['2q']
                flags[0] = True
            elif val > percents[1][j] and flags[1] == False:
                print 'got the second'
                xstats['lq'].append(x[i])
                flags[1] = True
            elif val > percents[2][j] and flags[2] == False:
                print 'got the third'
                xstats['median'].append(x[i])
                flags[2] = True
            elif val > percents[3][j] and flags[3] == False:
                print 'got the fourth'
                xstats['uq'].append(x[i])
                flags[3] = True
            elif val > percents[4][j] and flags[4] == False:
                print 'got the fifth'
                xstats['98q'].append(x[i])
                flags[4] = True
        if flags[4] == False:
            # this is what happens if it finds none of the above
            xstats['2q'].append(0.)
            xstats['lq'].append(0.)
            xstats['median'].append(0.)
            xstats['uq'].append(0.)
            xstats['98q'].append(0.)
    for k, v in xstats.items():
        xstats[k] = array(v)
    return xstats
