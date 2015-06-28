function one_field(varargin)
%ONE_FIELD is a method that will fetch feild file from remote host and
% process them in one step
% input: varargin can not be cell but parameters
% exmples:
%   one_file('20150608_10','20150608_12',...);

    close all;
    n = length(varargin);
    
       
    % field flag
    flag = {'x','y','z'};
    
    % remote path
    field_flag = {...
        fullfile('breakshell',varargin,'fielda'),...
        fullfile('breakshell',varargin,'fieldb')};
    
    % local path
    local_flag = {...
        fullfile(matlabroot,'bin\data\ddscat-data',varargin,'fielda'),...
        fullfile(matlabroot,'bin\data\ddscat-data',varargin,'fieldb')};
    
    f = ftp_get();
    % project is the default work directory
    cd(project);
    
    %process field file
    for i=1:n
        for j=1:2
            field_opt = field_flag{j};
            local_opt = local_flag{j};
            for k=1:3
                % status information
                display(fullfile(local_opt{i},flag{k}));
                
                % temp ddpostprocess.out dir
                ddp_dir=fullfile(field_opt{i},flag{k},'ddpostprocess.out');
                
                try
                    % fetch ddpostprocess.out from remote host
                    f.ftp_file(unix_path(ddp_dir));
                catch err
                    error(['can not fetch file ',unix_path(ddp_dir)]);
                end  
                
                % read field from ddpostprocess.out
                read_field(flag{k});
                close all;
                
                %check if local path is exits
                check_path(fullfile(local_opt{i},flag{k}));
                
                % local dir to store ddpostprocess.out
                tempdir = fullfile(local_opt{i},flag{k});
                
                % copy ddpostprocess.out field-flag.png and .. to dest dir
                copyfile(['field-',flag{k},'.png'],tempdir);
                copyfile(['field-',flag{k},'-watermark.png'],tempdir);
                copyfile('./ddpostprocess.out',tempdir);
            end
        end
    end
end
