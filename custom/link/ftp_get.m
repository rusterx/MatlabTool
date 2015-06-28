classdef ftp_get
% FTP_GET fetch data from server with default config and plot the data

    % define properties
    properties(Access='private')
        path;
        fn;
        f;
        root_path='/home/xing/Documents/ddscat_exp';
    end
    
    % define methods
    methods
        function fg = ftp_get()
            c = config();
            fg.f = ftp(c{1},c{2},c{3});   
        end
        
        function ftp_file(obj,full_path)
            [obj.path,obj.fn]=ftp_get.split_path(full_path);
            cd(obj.f,[obj.root_path,'/',obj.path]);
            mget(obj.f,obj.fn{1}); 
        end
        
        function ftp_close(obj)
            close(obj.f);
        end
    end
    
    methods(Static)
        function [path,fn]=split_path(full_path)
            path_arr = strsplit(full_path,'/');
            path = strjoin(path_arr(1:end-1),'/');
            fn = path_arr(end);
        end
    end
end

