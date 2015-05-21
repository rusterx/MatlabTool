function read_field(varargin)
%READ_FIELD read data from ddpostprocess.out and create a figure.
%   flag,nx,ny,hd,input_file
%   
%   Given parameters
%   ----------------
%         'flag'                  the value may be x,y or z
%         'nx'                    the num of x points
%         'ny'                    the num of y points
%         'hd'                    the num of headerlines
%         'input_file'            the input_file of ddpostprocess.out
%                                 may be relative
%                                 input_file and absoulte input_file


    [flag,nx,ny,hd,input_file] = parse_input(varargin);
   
    DELIMITER = ' ';
    HEADERLINES = hd;
    field=importdata(input_file,DELIMITER, HEADERLINES);
    data=field.data;
    
    if flag=='x'
        x=data(:,2);
        y=data(:,3);
        label_x='y(nm)';
        label_y='z(nm)';
    end
    
    if flag=='y'
        x=data(:,1);
        y=data(:,3);
        label_x='x(nm)';
        label_y='z(nm)';
    end
    
    if flag=='z'
        x=data(:,1);
        y=data(:,2);
        label_x='x(nm)';
        label_y='y(nm)';
    end
    
    
    e=sqrt((abs(complex(data(:,4),data(:,5)))).^2+(abs(complex(data(:,6),...
        data(:,7)))).^2+(abs(complex(data(:,8),data(:,9)))).^2);
    xr=reshape(x,nx,ny);
    xy=reshape(y,nx,ny);
    xe=reshape(e,nx,ny);
        
    pcolor(xr*1000,xy*1000,xe); 
        
    % set figure properties
    shading interp
    %set(gca,'FontName','Times New Roman','FontSize',7);
    set(gcf,'renderer','zbuffer');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 6.5 3]);
    
    
    % add arrow and text indicate wave vector and wave vibrating direction
    annotation('doublearrow',[0.15,0.21],[0.78,0.78],'HeadStyle',...
        'vback2','HeadSize',5);
    annotation('arrow',[0.18,0.18],[0.83,0.73],'HeadStyle','vback2',...
        'HeadSize',5);
    
    text(-73,37,'\fontsize{7}{0}\selectfont$\stackrel{\longrightarrow}{E_0}$')
    text(-86,24,'$k$')
    
    % a demo about how to add xlabel of colorbar
    % the position of the xlabel of colorbar is relative to colorbar
    % warning('off')
    colorbar()
    xlabel(colorbar,'\fontsize{7}{0}\selectfont$|E/E_0|$','Position',...
        [0.4,-0.7,0]);
    colormap(jet(64))
    
    % set label
    xlabel(label_x);
    ylabel(label_y);
    axis tight 
    
    % use floor function will improve contrast
    clim = get(gca, 'clim');
    set(gca, 'CLim', floor(clim));
          
    % print figure
    print(gcf, '-dpng','-r500', 'field.png');
end


function [flag,nx,ny,hd,input_file]=parse_input(varargin)
%PARSE_INPUT parse varargin into five parameter  

    nargs = length(varargin{1});
    if nargs>1 && nargs<5
        error('Bad input parameter numbers for nargin>1 && nargin<5.');
    end
    
    if nargs==0
        flag='z';
        nx = 200;
        ny = 200;
        hd = 17;
        input_file = 'ddpostprocess.out';        
    end
    
    if nargs==1
        flag = nargs{1};
        nx = 200;
        ny = 200;
        hd = 17;
        input_file = 'ddpostprocess.out';
    end
    
    if nargs==5
        flag = nargs{1};
        nx = nargs{2};
        ny = nargs{3};
        hd = nargs{4};
        input_file = nargs{5};       
    end
end