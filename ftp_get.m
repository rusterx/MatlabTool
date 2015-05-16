classdef ftp_get
% FTP_GET fetch data from server with default config and plot the data

    % define properties
    properties(Access='private')
        path;
        fn;
        f;
    end
    
    % define methods
    methods
        function fg = ftp_get()
            fg.f = ftp('js.mplant.pw','xing','123654ax');
            cd(fg.f,'/home/xing/Documents/ddscat_exp');      
        end
        
        function ftp_file(obj,full_path)
            [obj.path,obj.fn]=ftp_get.split_path(full_path);
            cd(obj.f,obj.path);
            mget(obj.f,obj.fn{1}); 
            cd(obj.f,'/home/xing/Documents/ddscat_exp'); 
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

