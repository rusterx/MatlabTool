function roman_avg(varargin)
%ROMAN_AVG average roman intensity data from file name list.
%   nargin is at least not less than 2 for parameters has at least one 
%   input file name and one output file name.
%   genearally, output file has the ext of '.csv' and its value seperated
%   with dot.
%   
%   Examples:
%       roman_avg('2-1.txt','2-2.txt','2-3.txt','2-base.csv');
%   
%   2-1.txt,2-2.txt,2-3.txt are raw data files created by labspec.

    if nargin<2
        error('Bad input parameter numbers.');
    end
    
    % length of input file list
    N = nargin-1;
    
    % initial read data from first file
    init_fn = varargin{1};
    init_data = importdata(init_fn,'\t',0);
    x_raw = init_data(:,1);
    y = zeros(length(x_raw),1);

    % add intensity data of roman signal of all files.
    for i=1:N
        temp_fn = varargin{i};
        temp_data = importdata(temp_fn,'\t',0);
        y = y+temp_data(:,2);
    end
    
    % averaging
    y = y./N;
    
    % save data
    dlmwrite(varargin{end},[x_raw,y],',');     
end