function read_3field(nx,ny,nz,hd,path)
    DELIMITER = ' ';
    HEADERLINES = hd; 
    field=importdata(path,DELIMITER, HEADERLINES);
    data=field.data;
    
    e=sqrt((abs(complex(data(:,4),data(:,5)))).^2+(abs(complex(data(:,6),...
        data(:,7)))).^2+(abs(complex(data(:,8),data(:,9)))).^2);
   % rx=reshape(data(:,3),nx,ny,nz)*1000;
   % ry=reshape(data(:,2),nx,ny,nz)*1000;
   % rz=reshape(data(:,1),nx,ny,nz)*1000;
    re=reshape(e,nx,ny,nz);
    [x,y,z]=meshgrid(linspace(-100,100,80),linspace(-50,50,80),linspace(-50,50,80));
    slice(x,y,z,re,[0,100],[0,50],[-50,0]);
    colorbar()
    colormap(jet(64))
    shading interp
    set(gcf,'renderer','zbuffer');
    print('all.png','-dpng','-r500');
end