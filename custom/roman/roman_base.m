function roman_base(input_file, output_file)
%ROMAN_BASE semi-automatic method of baseline correction
%   The grid vectors are not strictly monotonic increasing.
%   if occured this error means that next x point should bigger than pre
%   x point.
%   
%   automatic baseline
%        x_1 = x_raw(1);
%        x_2 = x_raw(end);
%        y_1 = y_raw(1);
%        y_2 = y_raw(end);
%        y_auto = y_raw-y_1-((y_2-y_1)/(x_2-x_1)).*(x_raw-x_1);  
%        h_auto_bs = plot([x_1,x_2],[y_1,y_2],'k-');
%        h_auto = plot(x_raw, y_auto,'r-');

    close all;
    if nargin<2
        error('Bad input parameter number.');
    end

    DELIMITER=',';
    HEADERLINES=0;
         
    data = importdata(input_file,DELIMITER, HEADERLINES);  
    hold on
    
    % extract data from input file and plot the data.
    x_raw = data(:,1);
    y_raw = data(:,2);
    h_raw = plot(x_raw,y_raw,'b-');
    xlabel('Roman Shift$(cm^{-1})$');
    ylabel('Intensity$(a.u.)$');
    title(['Baseline Corrention of ',upper(input_file)]);
     
    % read_input is based on ginput but extend its function which can
    % draw the point you click to help create a fit baseline.
    [x_bs,y_bs]=read_input();
    % sort_data can sort data according first array, if x(i) is le x(i-1) 
    % than x(i) will be deleted from x so interpl will not run with error.
    [x_sorted,y_sorted] = sort_data(x_bs,y_bs);
    y_bsline = interp1(x_sorted,y_sorted,x_raw,'spline');
    
    % plot baseline correted data
    y_semi = y_raw-y_bsline;
    h_semi_bs = plot(x_raw,y_bsline,'c-.');
    h_semi = plot(x_raw,y_semi,'c-');
    
    % add legend
    legend([h_raw,h_semi_bs,h_semi],...
        'raw','semi-baseline','semi');
    hold off
        
    % save data
    dlmwrite(output_file,[x_raw,y_semi],',');
  
    % improve quality of output figure.
    set(gcf,'renderer','zbuffer');
    print(gcf, '-dpng','-r500', [output_file(1:end-4),'.png']);    
end

function [x,y]=sort_data(a,b)
%SORT_DATA can sort data according first array.

    Na = length(a);
    Nb = length(b);
    
    % pre allocate
    x_mid = zeros(Na,1);
    y_mid = zeros(Nb,1);
   
    if Na~=Nb
        error('data to be sorted don`t have equal length.');
    end
    
    % sorted data accrod a
    for i=2:Na
        if a(i)>a(i-1)
            x_mid(i) = a(i);
            y_mid(i) = b(i);
        end
    end
    
    % shrink x_mid and y_mid
    [r,~] = find(x_mid~=0);
    x = x_mid(r);
    y = y_mid(r);
    
end

