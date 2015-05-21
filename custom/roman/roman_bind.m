function roman_bind(varargin)
%ROMAN_BIND can bind roman intensity data which has baseline corrected.
%   varargin should in format: filename,y_base,filename,y_base...,legend
%   
%   Examples:
%       roman_bind('data1.csv',200,'data2.csv',0,{'200','0'})
%   
%   nargin should not smaller than 3

    close all;
    if mod(nargin,2)~=1 || nargin==1
        error('Bad input params number.');
    end
    
    % initial data read
    N = floor(nargin/2);
    data = importdata(varargin{1},',',0);
    data_len = length(data(:,1));
    x_raw = data(:,1);
    y_raw = zeros(data_len,N);
    
    % colors set
    custom_color = {'r','g','b','c','m','y','k','w'};
    
    % process y data
    for i=1:N
        fi = varargin{2*i-1};
        data_i = importdata(fi,',',0);
        y_raw(:,i) =data_i(:,2)+varargin{2*i};   
    end
   
    % plot all the data
    hold on
    for i=1:floor(nargin/2)
        plot(x_raw,y_raw(:,i),custom_color{i});
    end
    hold off
    
    xlabel('Roman Shift$(cm^{-1})$');
    ylabel('Intensity$(a.u.)$');
    lg=legend(gca,'String',varargin{end});
    set(lg,'Position',[0.65 0.8 0.3 0.1]);
    set(gca,'linewidth',1);
    
    % save data
    dlmwrite('roman.csv',[x_raw,y_raw],','); 
    
    % print png
    set(gcf,'renderer','zbuffer');
    print(gcf,'-dpng','-r500','roman.png');
    
end