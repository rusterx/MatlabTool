function read_spec(varargin)
%READ_SPEC read data from input file and plot it as spectrum figure.
%   input_file is the file contains spectrum data created by ddscat
%   generally its name is qtable

    close all;
    DELIMITER = ' ';
    HEADERLINES = 14;
    
    if nargin == 0
        input_file = 'qtable';
    else
        input_file = varargin{1};
    end
    
    % extract data from qtable
    % generally if HEADERLINES is bigger than 1 than importdata return
    % a struct
    spec = importdata(input_file,DELIMITER,HEADERLINES);
    data = spec.data;
    vl = data(:,2)*1000;
    Q_ext = data(:,3);
    Q_abs = data(:,4);
    Q_sca = data(:,5);
    
    % draw data
    hold on
    plot(vl,Q_ext,'linewidth',2,'color','c');
    plot(vl,Q_abs,'linewidth',2,'color','b');
    plot(vl,Q_sca,'linewidth',2,'color','r');
    hold off
    
    set(gca,'FontSize',12,'linewidth',1.5);

    % get array points
    get_peaks();
        
    ld=legend('Extinction','Absorption','Scattering');
    set(ld,'position',get(ld,'position')+[-0.5 0 0 0],'box','off');
    xlabel('Wavelength(nm)');
    ylabel('Absorbance(a.u.)');
    
    % set some properties of plot
    set(gcf,'renderer','painters');
    
    % print figure
    print(gcf,'-dpng','-r500','spectrum.png');
end


function get_peaks()
%GET_PEAKS is based on ginput and create label using cord of peaks
%   if you want terminal ginput press ENTER key on keyboard

    [x,y]=ginput();
    for i=1:length(x)
        gtext(['(',num2str(x(i)),',',num2str(y(i)),')']);
    end
end