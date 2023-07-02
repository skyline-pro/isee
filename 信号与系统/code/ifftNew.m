function Y = ifftNew(x)
    length_x = length(x);

    %对序列x进行补零
    bit_counter = 0;
    length_after_add_zero = 1;
    while(length_after_add_zero < length_x)%每次循环左移一位
        length_after_add_zero = bitshift(int32(length_after_add_zero) , 1);
        bit_counter = bit_counter + 1;
    end

    if(bit_counter < 10)
        bit_counter = 10;
        length_after_add_zero = pow2(10);
    end

    x = [x , zeros(1,length_after_add_zero - length_x)];
    
    %得到数组rev，rev(i)存放的为傅里叶变换中需要交换位置的值
    rev = zeros(length_after_add_zero,1);
    for i = 0:1:length_after_add_zero-1
        rev(i+1) = bitor(int32(floor( (rev( floor(i/2)  + 1 ))/2 ) ) , bitshift(int32(bitand(int32(i),1)), bit_counter-1)) + 1;
    end

    %将输入序列调整为fft需要的顺序
    for i = 1:1:length_after_add_zero
        if(i <= rev(i))
            temp = x(i);
            x(i) = x(rev(i));
            x(rev(i)) = temp;
        end
    end

    for L = 1:1:bit_counter
        B =int32(pow2(L-1));
        for m = 0:1:B-1
            k = int32(pow2(bit_counter - L));
            P = m*k;
            for i = 0:1:k-1
                r = m + 2*B*i;
                temp = x(r+1);
                x(r+1) = x(r+1) + x(r+B+1)*exp(1j*double(2*pi*double(P)/double(length_after_add_zero)));
                x(r+B+1) = temp - x(r+B+1)*exp(1j*double(2*pi*double(P)/double(length_after_add_zero)));                
            end
        end
    end

    Y = zeros(1 ,length_x);
    
    if(length_after_add_zero ~= length_x)
        for m = 1:1:length_x
            number = floor(double((m-1)*length_after_add_zero)/double(length_x));
            after = double(number+1)/double(length_after_add_zero);
            before = double(number)/double(length_after_add_zero);
            this = double(m-1)/double(length_x);

            Y(m) = (after-this)*x(number+1)*double(length_after_add_zero) + (this - before)*x(number+2)*double(length_after_add_zero);
        end
    end
    Y = Y ./ length_x;

end