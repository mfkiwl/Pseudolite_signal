% ����Ƶ��4��α���ǣ�������
%������10.23MHz��������200us=2046chip

function [ PRN, PRN_edge ] = B4_codegen( SatNum, Isbpsk, PN_shift )

%     % table of C/A Code Tap Selection (sets delay for G2 generator)
   G2x_table = [ 1 0 1 0 0 1 1 0 0 1;
       1 1 1 1 0 1 0 1 0 1;
       0 0 0 1 1 1 1 1 1 0;
       0 1 1 1 0 0 1 1 1 0;
       1 0 0 0 0 1 1 0 1 1 ];

    % initialization  vector  for  G1
    G1x = [1 1 0 1 0 1 0 0 1 1];
    % G1x  LFSR: 1 + x + x^7 + x^8 + x^9 + x^10 + x^11
    g1_sel = [0 0 1 0 0 0 0 0 0 1];

    % initialization  vector  for  G2
    G2x = G2x_table(SatNum,:);
    % G2x  LFSR: 1 + x + x^2 + x^3 + x^4 + x^5 + x^8 + x^9 + x^11
    g2_sel = [0 1 1 0 0 0 0 1 0 1];

    n = length(G1x); 
    L = 2^n - 1;  % L = 1023

    % generate C/A Code sequence:
    PRN = zeros(1,L);
    for i=1:1:L
        PRN(i) = mod( ( G1x(10) + G2x(10) ), 2 );
        G1x = [mod( sum( G1x.*g1_sel ), 2 ),  G1x(1:9)];
        G2x = [mod( sum( G2x.*g2_sel ), 2 ),  G2x(1:9)];
    end

    % BPSK���ƣ�
    % ȡ��ԪΪ'1'ʱ�����ƺ��ز���δ�����ز�ͬ�ࣻ
    % ȡ��ԪΪ'0'ʱ�����ƺ��ز���δ�����ز����ࣻ
    % '1'��'0'ʱ���ƺ��ز���λ���180�㡣
    if (Isbpsk~=0)
        PRN = 1 - 2*PRN;
    end

    PRN_edge = zeros(1, L);
    PRN_edge(1) = 1;
    if (PN_shift~=0)
        PRN = [PRN(PN_shift+1:end), PRN(1:PN_shift)];
        PRN_edge = [PRN_edge(PN_shift+1:end), PRN_edge(1:PN_shift)];
    end

end
