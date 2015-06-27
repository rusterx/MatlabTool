function read_spec_all(varargin)
%READ_SPEC_ALL read spectrum from qtable in different table. default,
%   varargin is a cell with such format {'folder1','folder2'}
%   if varargin contains only one parameters then it is not a cell but the
%   type of the parameters itself.
    close all;
    hold on;
    colors = {'r-','m-','c-','g-','b-','k-','y-'};
    % take care that varargin{1} items should be like 'xxxx_yy'
    varargin_list = varargin{1};  
    path_list = fullfile('ddscat-data',varargin_list,'qtable');
    init_file = path_list{1};
    N = length(path_list);
    legend_cell = cell(1,N);
    
    % draw first line
    [init_vl, init_Q_sca] = read_single(init_file);
    plot(init_vl,init_Q_sca,colors{1},'linewidth',1.5);
    
    for i=2:N
        tmp_file = path_list{i};
        [tmp_vl,tmp_Q_sca] = read_single(tmp_file);
        % use interp method to avoid different data length;
        Q_sca_interp = interp1(tmp_vl, tmp_Q_sca, init_vl, 'spline');
        plot(init_vl,Q_sca_interp,'color',[rand(),rand(),rand()],...
            'linewidth',1.5);
    end
    
    % add legend cell
    for i=1:N
        tmp_ind = strfind(varargin_list{i},'_');
        tmp_str = varargin_list{i}(tmp_ind+1:end);
        legend_cell{i}=['offset ',tmp_str,'nm'];
        read_peak(path_list{i});
    end
    
    set(gca,'FontSize',12,'linewidth',1.5);
    axis([400 1200 0 17]);
    
    % automatic set legend
    hl = legend(legend_cell);
    set(hl,'position',get(hl,'position')+[-0.5 0 0 0],'box','off');
    
    xlabel('Wavelength(nm)');
    ylabel('Abs.(a.u.)');
    set(gcf,'renderer','zbuffer');
    print(gcf,'-dpng','-r500','all_spectrum.png');
end

function [vl,Q_sca]=read_single(input_file)
    DELIMITER = ' ';
    HEADERLINES = 14;
    spec = importdata(input_file,DELIMITER,HEADERLINES);
    data = spec.data;
    vl = data(:,2)*1000;
    Q_sca = data(:,3);  
end