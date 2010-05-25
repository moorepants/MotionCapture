import pickle as p

# load runInfo.txt into a dictionary
f = open('../data/runInfo.txt', 'r')
# intialize the lists for each item in runInfo
run = rider = bike = condition = speed = gear = []
run = [line[:-1].split(',')[0] for line in f]
f.seek(0)
rider = [line[:-1].split(',')[1] for line in f]
f.seek(0)
bike = [line[:-1].split(',')[2] for line in f]
f.seek(0)
condition = [line[:-1].split(',')[3] for line in f]
f.seek(0)
speed = [line[:-1].split(',')[4] for line in f]
f.seek(0)
gear = [line[:-1].split(',')[5] for line in f]
f.close()

f = open('../data/sensorlocation.txt', 'r')
num = [line[:2].strip() for line in f]
f.seek(0)
name = [line[2:-1].strip() for line in f]
f.close()
markLoc = {'num': num, 'name': name}
f = open('../data/markLoc.p', 'w')
p.dump(markLoc, f)
f.close()
# define a dictionary of lists for each item in run info
runInfo = {run[0]: run[1:], rider[0]: rider[1:], bike[0]: bike[1:], gear[0]:
        gear[1:], speed[0]:speed[1:], condition[0]: condition[1:]}

f = open('../data/runInfo.p', 'w')

p.dump(runInfo, f)

f.close()
