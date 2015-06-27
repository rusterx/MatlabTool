function watermark(annotation_file,input_file)
%WATERMARK add watermark to field figure
    
    warning('off','all');
    % args process and annotation_file is y-annotation.png
    annotation=fullfile(matlabroot,...
        'bin\data\annotation\annotation',annotation_file);
              
    [ai,~,alpha]=imread(annotation);
    % temp_field(1:end-1) remove \n at the end of temp_filed
    yi = imread(input_file);

    alpha_resize = repmat(alpha,[1 1 3]);
    alpha_resize = im2double(alpha_resize);

    yi = uint8(alpha_resize.*double(ai)+(1-alpha_resize).*double(yi));
    
    [p,n,~] = fileparts(input_file);
    output_file = fullfile(p,[n,'-watermark.png']);

    % don't show figure
    temp_h = figure();
    set(temp_h,'visible','off');      
    imshow(yi);

    set(gcf,'renderer','zbuffer');
    print(gcf,'-dpng','-r300',output_file);
    warning('on','all');

end







