% design of a general pseudolite pulsing scheme
% 仿真周期性伪随机脉冲序列的相关函数
% 1. R_dirac(aNc+bdNc)
% 2. R_p(aNc+bdNc)

clear all; close all; clc;


% 参数设置
Nc = 1023;
d = 0.1;
N = 1/d;
k = 20;
Ne = k*N;

b = 0:N-1;
a = 0:9;

len_a = length(a);
R_dirac = zeros(N*len_a,1);
L = zeros(N*len_a,1);
for j=1:len_a
    for i=1:N
        index = (j-1)*N + i;
        L(index) = (a(j)*N + b(i));
        tmp = mod(a(j),Ne);
        if (~tmp )
            if ( ~b(i) )
                R_dirac(index) = 1;
            else
                R_dirac(index) = b(i)*(N+1)/N^3;
            end
        else
            if (tmp < N)
                if ( ~b(i) )
                    R_dirac(index) = tmp/N^2;
                else
                    R_dirac(index) = (N^3 - tmp*N - b(i))/((N+1)*N^3);
                end
            else
                R_dirac(index) = 1/N;
            end
        end
    end    
end
R_dirac = [R_dirac(end:-1:2); R_dirac];    
L = [-L(end:-1:2);L];
figure
plot(L/N,R_dirac)
title('R-dirac')

% rectangle = zeros(Nc,1);
% Np = floor(d*Nc);
% rectangle(1:Np) = 1;
% figure
% plot(rectangle)
% title('rectangle')
% 
% triangle = 1/Np*conv(rectangle,rectangle,'full');
% figure
% plot(triangle)
% title('triangle')
% 
% R_p = conv(R_dirac,triangle,'same');
% figure
% plot(R_p)
% title('R_p')


