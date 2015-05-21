function roman_all()
%ROMAN_ALL combine all the operation in one file
%   so you can call this one function two finish data process

    roman_avg('rod');
    roman_avg('shell');
    
    % roman_base('1-avg.txt','1-base.csv')
    roman_base('rod-avg.csv','rod-base.csv')
    roman_base('shell-avg.csv','shell-base.csv')
   
    % bind all the roman signal
    roman_bind('shell-base.csv',200,'rod-base.csv',0,{'breakshell','nanorod'})
end