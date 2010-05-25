h1 = plot(yb(1,1:20),-zb(1,1:20),'r.');
axis([-2 2 -1 2])
for i = 2:6000
    set(h1,'XData',yb(i,1:20),'YData',-zb(i,1:20))
    pause(0.001)
end