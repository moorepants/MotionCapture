from numpy import load
from matplotlib.pyplot import plot, show, legend, title, figure, subplot, ylim, axis
from mpl_toolkits.mplot3d import Axes3D

HipVec = load('../data/npy/hip/3080Hip.npy')

figure(1)
subplot(2, 1, 1)
plot(HipVec[:, 0, :])
title('Right Hip')
legend(['X', 'Y', 'Z'])

subplot(2, 1, 2)
plot(HipVec[:, 1, :])
title('Left Hip')
legend(['X', 'Y', 'Z'])

figure(2)
# right hip
plot(-HipVec[:, 0, 1], -HipVec[:, 0, 2], '.')
# left hip
plot(-HipVec[:, 1, 1], -HipVec[:, 1, 2], '.')
# plot butt
plot(-HipVec[:, 2, 1], -HipVec[:, 2, 2], '.')
ylim([0, .3])
axis('equal')
legend(['Right Hip', 'Left Hip', 'Butt'])
show()
