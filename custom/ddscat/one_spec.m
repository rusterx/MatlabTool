function one_spec(varargin)
%ONE_SPEC means one step to fetch all qtable from remote host and draw them
%and save them into each folders  
%   examples:
%   one_spec('20150608_10','20150608_12');

    close all;
    n = length(varargin);
    remote_path = fullfile('breakshell',varargin,'qtable');
    local_path = fullfile(matlabroot,'bin\data\ddscat-data',varargin);
    
    f = ftp_get(); 
    cd(project);
    
    % process qtable
    for i=1:n
        % fetch remote qtable file
        f.ftp_file(unix_path(remote_path{i}));
        % create spectrum png file
        read_spec();
        % write peak data
        read_peak('./qtable');
        % copy file to remote dir
        copyfile('./qtable',local_path{i});
        copyfile('./spectrum.png',local_path{i});
    end    
end