function judge_series = judge(sample)
    judge_series = zeros(1 , length(sample));
for i = 1:1:length(sample)
    if sample(i) > 2
        judge_series(i) = 3;
    elseif sample(i) > 0
        judge_series(i) = 1;
    elseif sample(i) > -2
        judge_series(i) = -1;
    else
        judge_series(i) = -3;
    end
end
end

