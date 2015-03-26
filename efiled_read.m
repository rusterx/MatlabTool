function efiled_read(full_path)
    clc;close all;
    fid = fopen(full_path);
    fgetl(fid);
    lineinfo = fgetl(fid);
    info_array = strsplit(lineinfo,',');
    x_size = str2double(info_array(2));
    y_size = str2double(info_array(3));
    [A,B,C] = textread(full_path','%f %f %f','headerlines',2,'endofline','\n','delimiter',',');
    fclose(fid);
    pcolor(reshape(A,x_size,y_size),reshape(B,x_size,y_size),reshape(C,x_size,y_size));
    colorbar()
    shading interp;
end