import pickle

class marker():
    def __init__(self, number, group):
        self.number = number
        self.group = group
    def name(self):
        if self.group == 'one':
            f = open('../data/markLoc.p', 'r')
            markLoc = pickle.load(f)
            f.close()
            self.name = markLoc['name'][markLoc['num'].index(str(self.number))]
        else:
            print 'there is no', self.group


