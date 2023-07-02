function [code,len] = channel_decode(BPSK_REC_Data,trellis)
%BPSK_REC_Data=[BPSK_REC_Data(1:end);x];
%d = vitdec(BPSK_REC_Data,trellis,tblen,'trunc','hard');
%code=d(tblen*k+1:end);
code = vitdec( BPSK_REC_Data,trellis,34,'trunc','hard');
len = length(code);
end

