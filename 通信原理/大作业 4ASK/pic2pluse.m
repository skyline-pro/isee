function [x , n] = pic2pluse(pic , fs , fb)
    % 此函数用于将图片转换为脉冲成型序列
    
    m = fs/fb;
    %按RGB三通道读取图片
    r_origin = reshape(pic(:,:,1),1,[]);
    g_origin = reshape(pic(:,:,2),1,[]);
    b_origin = reshape(pic(:,:,3),1,[]);
    % 获取单个通道的长度
    n = size(r_origin , 2);
    
    r_progress = zeros(1,4*n*m);
    g_progress = zeros(1,4*n*m);
    b_progress = zeros(1,4*n*m);
    for i=1:1:n
        r = dec2base(r_origin(1,i),4,4);
        g = dec2base(g_origin(1,i),4,4);
        b = dec2base(b_origin(1,i),4,4);
        for j = 1:1:4
            r_temp = 2*str2double(r(j))-3;
            g_temp = 2*str2double(g(j))-3;
            b_temp = 2*str2double(b(j))-3;
            for k = 1:1:m
                r_progress(4*m*(i-1)+m*(j-1)+k) = r_temp;
                g_progress(4*m*(i-1)+m*(j-1)+k) = g_temp;
                b_progress(4*m*(i-1)+m*(j-1)+k) = b_temp;
            end           
        end
    end
    x = [r_progress , g_progress , b_progress];
end

