function watermark_all(varargin)
%WATERMARK_ALL add watermark to field figure
   
    % input args processing
    if nargin<1
        error('Parameters number error.');
    end
    
    if nargin==1
        dir_part = 'field-y.png';
        annotation_file = 'y-annotation.png';
        folder_pref = varargin{1};      
    elseif nargin==2 && ~isempty(find('yz'==varargin{1}, 1))
        dir_part = ['field-',varargin{1},'.png'];
        annotation_file = [varargin{1},'-annotation.png'];
        folder_pref = varargin{2};
    else
        error('Parameters error.');
    end
    
    % project path and get sub dir.
    project_path = 'D:\Program Files\MATLAB\R2013a\bin\data\ddscat-data';
    cd(project_path);
    folders = dir(folder_pref);
    
    % don't show warning
    warning('off','all');
    file_len = length(folders);
    
    for i=1:file_len
        % indicator of process
        display(['processing ',num2str(i),'/',num2str(file_len),' file...']);
        
        % use fullfile function but not use [], so code is crossplatform
        tpath = fullfile(project_path,folders(i).name);
        cd(tpath);
        [~, cmdout] = dos(['dir /b /a /S ',dir_part]); 
        temp_field = cmdout(1:end-1);   
        watermark(annotation_file,temp_field);

    end 
    
    % post process of some setting
    warning('on','all');
    cd(project_path);
    close all;
    display('processe finished...');
end







