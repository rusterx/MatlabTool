function read_vfield(sample,flag,nx,ny,hd, path)
    DELIMITER = ' ';
    HEADERLINES = hd; 
    
    field=importdata(path,DELIMITER, HEADERLINES);
    data=field.data;
    
    if flag=='x'
        x=data(:,2);
        y=data(:,3);
        e_x = data(:,6);
        e_y = data(:,8);
    end
    
    if flag=='y'
        x=data(:,1);
        y=data(:,3);
        e_x = data(:,4);
        e_y = data(:,8);
    end
    
    if flag=='z'
        x=data(:,1);
        y=data(:,2);
        e_x = data(:,4);
        e_y = data(:,6);
    end
    
  
    xr = 1000*reshape(x, nx, ny);
    yr = 1000*reshape(y, nx, ny);
    
    e_xr = reshape(e_x, nx, ny);
    e_yr = reshape(e_y, nx, ny);
    
    % sample the data
    xrs = xr(1:sample:end,1:sample:end);
    yrs = yr(1:sample:end,1:sample:end);
    e_xrs = e_xr(1:sample:end,1:sample:end);
    e_yrs = e_yr(1:sample:end,1:sample:end);
    
    % mo means moduli, so arrows can be same length
    mo = abs(complex(e_xrs,e_yrs));
    quiver(xrs, yrs, e_xrs./mo, e_yrs./mo, 0.7);
    
    xlabel('x')
    ylabel('y')
    axis tight
    
    set(gcf, 'renderer', 'zbuffer');
    print('quiver.png', '-dpng', '-r500');
       
end

