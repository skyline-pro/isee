function sample = trans(x,SNR,fs,fc)
    T = length(x);
    dt = 1/fs;
    t = 0:dt:(T-1)*dt;
    y = x.*cos(2*pi*fc*t);
    y = awgn(y,SNR,'measured');

    y = y.*cos(2*pi*fc*t);
    [b,a] = butter(2,2*fc/fs);
    y = filtfilt(b,a,y)*2;
    sample = y(2:32:end);
end

