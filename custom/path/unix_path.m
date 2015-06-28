function p = unix_path(path)
%UNIX_PATH change windows path seq to unix path seq

    p = strrep(path,'\','/');
end