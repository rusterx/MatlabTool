function cp(dest)
    flag = dest(end);
    if not(exist(dest,'dir'))
        mkdir(dest);
    end
    copyfile('./ddpostprocess.out',dest);
    copyfile(['./field-',flag,'.png'],dest);
    copyfile(['./field-',flag,'-watermark.png'],dest);
end