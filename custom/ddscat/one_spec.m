function one_spec(varargin)
%ONE_SPEC means one step to fetch all qtable from remote host and draw them
% and save them into each folders  
% varargin should be cell;

    close all;
    n = length(varargin);
    path_list = fullfile('breakshell',varargin,'qtable');
    local_path_list = fullfile(matlabroot,'bin\data\ddscat-data',varargin);
    project_path = fullfile(matlabroot,'bin\data');
    
    % fetch qtable and save into path
    f = ftp_get();
    for i=1:n
        f.ftp_file(strrep(path_list{i},'\','/'));
        copyfile('./qtable',local_path_list{i});
    end
    
    % save png files
    for i=1:n
        cd(local_path_list{i});
        read_spec();
    end
    
    cd(project_path);
    
    % write peak data
    for i=1:n
        read_peak(local_path_list{i});
    end  
end