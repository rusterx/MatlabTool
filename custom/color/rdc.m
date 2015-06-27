function color = rdc()
%RDC return random color of system
    colors = {'r','g','b','c','m','y','k'};
    i = randi(7);
    color = colors{i};
end