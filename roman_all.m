function roman_all()
%ROMAN_ALL combine all the operation in one file
%   so you can call this one function two finish data process

    % roman_avg('1-1.txt','1-2.txt','1-3.txt','1-avg.csv');
    roman_avg('2-1.txt','2-2.txt','2-3.txt','2-avg.csv');
    roman_avg('3-1.txt','3-2.txt','3-3.txt','3-avg.csv');
    roman_avg('4-1.txt','4-2.txt','4-3.txt','4-avg.csv');
    
    % roman_base('1-avg.txt','1-base.csv')
    roman_base('2-avg.csv','2-base.csv')
    roman_base('3-avg.csv','3-base.csv')
    roman_base('4-avg.csv','4-base.csv')
    
    % bind
    roman_bind('3-base.csv',100,'2-base.csv',50,'4-base.csv',0,{'50','20','0'})
end