classdef ssh<handle
%SSH send command, get command response, get file and upload file
%   ensure you can get corrent result, you may ensure that you have changed
%   into corrent path and '< handle' means that it is a handle class

    properties
        pwd='/home/xing/Documents/ddscat_exp/breakshell';
        conn;
    end
    
    methods
        function obj = ssh()
            obj.conn = ssh2_config('js.mplant.pw','xing','123654ax');
            ssh2_command(obj.conn,['cd ',obj.getpwd()]);       
        end
        
        % if you want to set properties of this class then you need to
        % change this value class to handle class
        function cd(obj,path)
            obj.pwd = fullfile(obj.pwd,path);
        end
        
        % send command to server
        function cmd(obj,cmdline)
            ssh2_command(obj.conn,['cd ',obj.getpwd(),';',cmdline]);
        end
        
        % get file from remote server and file can be string or cell
        function get(obj,file)
            scp_get(obj.conn,file,'./',obj.getpwd());
        end
        
        % upload file into server
        function put(obj,file)
            scp_put(obj.conn,file,obj.getpwd(),'./');
        end
        
        % return correct current path
        function path = getpwd(obj)
            path = strrep(obj.pwd,'\','/');
        end
        
        % close the connection session
        function close(obj)
            ssh2_close(obj.conn);
            clear all;
        end       
    end
  
end