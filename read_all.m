function read_all(sample,flag,nx,ny,hd, path)
    DELIMITER = ' ';
    HEADERLINES = hd; 
    
    field=importdata(path,DELIMITER, HEADERLINES);
    data=field.data;
    
    if flag=='x'
        x=data(:,2);
        y=data(:,3);
        e_x = data(:,6);
        e_y = data(:,8);
        label_x='y(nm)';
        label_y='z(nm)';
    end
    
    if flag=='y'
        x=data(:,1);
        y=data(:,3);
        e_x = data(:,4);
        e_y = data(:,8);
        label_x='x(nm)';
        label_y='z(nm)';
    end
    
    if flag=='z'
        x=data(:,1);
        y=data(:,2);
        e_x = data(:,4);
        e_y = data(:,6);
        label_x='x(nm)';
        label_y='y(nm)';
    end
    
    e=sqrt((abs(complex(data(:,4),data(:,5)))).^2+(abs(complex(data(:,6),...
        data(:,7)))).^2+(abs(complex(data(:,8),data(:,9)))).^2);
    xe=reshape(e,nx,ny); 
    e_xr = reshape(e_x, nx, ny);
    e_yr = reshape(e_y, nx, ny);
    xr = 1000*reshape(x, nx, ny);
    yr = 1000*reshape(y, nx, ny);  
    
    hold on
    pcolor(xr,yr,xe);
    % a demo about how to add xlabel of colorbar
    % the position of the xlabel of colorbar is relative to colorbar
    xlabel(colorbar,'$|E/E_0|$','Position',[0.4,-0.2,0],'Interpreter','latex')
    colormap(jet(64)) 
    clim = get(gca, 'clim');
    display(clim);
    % use floor function will improve contrast
    set(gca, 'CLim', floor(clim));
    % axis tight put in different area when a axes have multiple figs have
    % different function
    axis tight
  
    % sample the data
    xrs = xr(1:sample:end,1:sample:end);
    yrs = yr(1:sample:end,1:sample:end);
    e_xrs = e_xr(1:sample:end,1:sample:end);
    e_yrs = e_yr(1:sample:end,1:sample:end);
    
    % mo means moduli, so arrows can be same length
    mo = abs(complex(e_xrs,e_yrs));
    h=quiver(xrs, yrs, e_xrs./mo, e_yrs./mo,'Color','w');
    set(h,'AutoScaleFactor',0.6);
    hold off
    
    % set label    
    xlabel(label_x)
    ylabel(label_y)
    
    % set figure properties
    shading interp
    set(gca,'FontName','Consolas');    
    set(gcf,'renderer','zbuffer');
    
    % print figure
    print(gcf, '-dpng','-r500', 'all.png');      
end

