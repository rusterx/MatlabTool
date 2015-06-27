function lcd(varargin)
    if(isempty(varargin))
        cd('D:\Program Files\MATLAB\R2013a\bin\data');
    elseif(strcmp(varargin{1},'func'))
        cd('D:\Program Files\MATLAB\R2013a\bin\func\custom');
    end
end