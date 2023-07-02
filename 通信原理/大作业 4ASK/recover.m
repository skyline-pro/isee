function pic_recovered = recover(judge_series , n, w, h, c)
    judge_series = (judge_series+3)/2;
    pic_recover = zeros(1 , n*3);
    for i = 1:4:length(judge_series)       
        pic_recover((i-1)/4+1) = judge_series(i)*64+judge_series(i+1)*16+judge_series(i+2)*4+judge_series(i+3);
    end

    pic_recovered = uint8(reshape(pic_recover , [w,h,c]));
end

