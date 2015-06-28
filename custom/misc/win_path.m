function p=win_path(path)
%WIN_PATH change unix path seq to windows path seq

    p = strrep(path,'\','/');
end