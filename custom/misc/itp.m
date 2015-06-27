function itp(flag)
    if(strcmp(flag,'latex'))
        set(0,'defaultTextInterpreter','latex');
    end
    if(~strcmp(flag,'tex'))
        set(0,'defaultTextInterpreter','tex');
    end
end