function roman_avg(pref)
%ROMAN_AVG average roman intensity data from file name list.
%   nargin is at least not less than 2 for parameters has at least one 
%   input file name and one output file name.
%   genearally, output file has the ext of '.csv' and its value seperated
%   with dot.
%   
%   Examples:
%       if you have file: rod-1.txt,rod-2.txt,rod-3.txt,rod-4.txt
%       then you just have to type: roman_avg('rod');
%   
%   rod-1.txt,rod-2.txt,rod-3.txt,rod-4.txt are raw data files created by labspec.
    

    if nargin<1
        error('Bad input parameter numbers.');
    end
    
    file_struct = dir([pref,'*.txt']);
    N = length(file_struct);
     
    % initial read data from first file
    init_fn = file_struct(1).name;
    init_data = importdata(init_fn,'\t',0);
    x_raw = init_data(:,1);
    y = zeros(length(x_raw),1);

    % add intensity data of roman signal of all files.
    for i=1:N
        temp_fn = file_struct(i).name;
        temp_data = importdata(temp_fn,'\t',0);
        y = y+temp_data(:,2);
    end
    
    % averaging
    y = y./N;
    
    % save data
    dlmwrite([pref,'-avg.csv'],[x_raw,y],',');     
end