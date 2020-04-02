% ���� <����α�����ź�Զ��ЧӦ�������������о�-���>
% P25,B1I����빦�����ܶ�
% ���������ʽ2-25���ܻ���ͼ2-8�����ҷ�����ʽ�ã�Ƶ�׼������1kHz��
clear all; close all; clc;
n = 11;
N = 2^n - 2;
m = [-100000:-1,1:100000];
len1 = length(m);
fc = 2.046e6; Tc = 1/fc;
ww = -10e3:1:10e3;
len2 = length(ww);

sw = zeros(1,len2);
for i=1:len2
    w = ww(i);
    d1 = dirac(w);
    idx1 = d1 == Inf; % find Inf
    d1(idx1) = 1;
    d2 = dirac(w+2*m*pi/N/Tc);
    idx2 = d2 == Inf; % find Inf
    d2(idx2) = 1;
    sw(i) = d1 + sum( (N+1)*(sinc(m*pi/N)).^2.*d2 );
end
figure
stem(ww,sw,'.')