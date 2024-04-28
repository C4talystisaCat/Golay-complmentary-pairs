% 给定的基数
q = 4;
m=3;
%产生两个序列
[F,G]=GDJ_GCP(m,q);

f = double(F(5,:));
g = double(G(5,:));


% 将序列转换为复数信号
complex_f = convert_to_complex(f,q);
complex_g = convert_to_complex(g,q);

% 计算互相关
rxy = xcorr(complex_f, complex_g);
rxx = xcorr(complex_f, complex_f);
ryx = xcorr(complex_g, complex_f);
ryy = xcorr(complex_g, complex_g);

% 计算互相关函数
C1 = abs(rxx + ryy);
C2 = abs(rxy + ryx);
    % 将非常小的值改为0
    C1(C1 < 0.1) = 0;
    C2(C2 < 0.1) = 0;

% 绘制带有延迟标签的stem图
figure;
stem(-length(f)+1:length(f)-1, C1, 'filled');
xlabel('Delay');
ylabel('ACCF');
title('AACF of Sequences F and G (R_x(tau)+R_y(tau))');
grid on;

figure;
stem(-length(f)+1:length(f)-1, C2, 'filled');
xlabel('Delay');
ylabel('ACCF');
title('ACCF of Sequences F and G (R_x,y(tau)+R_y,x(tau))');
grid on;

disp(F)
disp(G)
ZCZ(C1,C2)