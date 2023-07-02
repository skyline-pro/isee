function command = recognize(r_out, fs)
load('commandNet.mat');
auditorySpect = helperExtractAuditoryFeatures(r_out,fs);
command = classify(trainedNet,auditorySpect);
fprintf("识别结果：")
disp(command);
end
