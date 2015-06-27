function read_peak(input_file)
%READ_PEAK from qtable and save peak info into peaks.log
    spec = importdata(input_file,' ',14);
    data = spec.data;
    x_data = data(:,2)'*1000;
    y_data = data(:,3)';
    x_minmax = minmax(x_data);
    data_series = linspace(x_minmax(1),x_minmax(2),2000);
    y_data_interp = interp1(x_data,y_data,data_series);
    % hold on
    % plot(data_series,y_data_interp);
    [pks,loc] = findpeaks(y_data_interp,'NPEAKS',2);
    % scatter(data_series(loc),pks,'s');
    % hold off
    dlmwrite('peaks.log',[data_series(loc),pks],...
        '-append','delimiter', '\t');
end