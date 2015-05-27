function watermark(varargin)
%WATERMARK add watermark to field figure
   
    % input args processing
    if nargin<1
        error('Parameters number error.');
    end
    
    if nargin==1
        dir_part = 'field-y.png';
        annotation=fullfile(matlabroot,...
            'bin\data\annotation\annotation\y-annotation.png');
        folder_pref = varargin{1};
    end
    
    if nargin==2 && varargin{1}=='z'
        folder_pref = varargin{2};
        dir_part = 'field-z.png';
        annotation=fullfile(matlabroot,...
            'bin\data\annotation\annotation\z-annotation.png');
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
        temp_field = cmdout;  
        temp_path = fileparts(temp_field);
        temp_output = fullfile(temp_path,['watermark-',dir_part]);
   
        %%%%%%%%%%%%%%%%%%%%%%%%%%% Core Code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % process image
        [ai,~,alpha]=imread(annotation);
        % temp_field(1:end-1) remove \n at the end of temp_filed
        yi = imread(temp_field(1:end-1));

        alpha_resize = repmat(alpha,[1 1 3]);
        alpha_resize = im2double(alpha_resize);

        yi = uint8(alpha_resize.*double(ai)+(1-alpha_resize).*double(yi));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % don't show figure
        temp_h = figure(i);
        set(temp_h,'visible','off');      
        imshow(yi);
        
        set(gcf,'renderer','zbuffer');
        print(gcf,'-dpng','-r300',temp_output);

    end 
    
    % post process of some setting
    warning('on','all');
    cd(project_path);
    close all;
    display('processe finished...');
end







