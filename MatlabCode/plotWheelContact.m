h1 = plot(xn(1,39),yn(1,39),'r.')
for i = 2:6000
    set(h1,'XData',xn(1:i,39),'YData',yn(1:i,39))
    pause(0.001)
end