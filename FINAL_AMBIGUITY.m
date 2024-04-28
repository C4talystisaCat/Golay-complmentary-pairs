% 定义输入参数
[F,G] = GDJ_GCP(6,4); % N 进制数据序列
f=F(1,:);
phases = [0 pi/2 pi 3*pi/2]; % 每个相位对应的相位值（这里示例为 0、π/2、π、3π/2）
N = 4; % 进制数为 4
symbol_rate = 10; % 符号速率为 10 符号/秒
sampling_rate = 1000; % 采样率为 1000 采样/秒

% 生成信号
signal = generate_nary_code(f, phases, N, symbol_rate, sampling_rate);
PRF=10;
% 绘制信号波形
t = (0:length(signal)-1) / sampling_rate; % 时间向量
figure;
plot(t, real(signal)); % 绘制信号的实部
xlabel('Time (s)');
ylabel('Amplitude');
title('Generated N-ary Coded Signal');

% 计算模糊函数
[afmag, delay, doppler] = ambgfun(signal, sampling_rate, PRF);

% 绘制三维模糊函数
figure;
surf(delay, doppler, afmag, 'EdgeColor', 'none');
xlabel('Delay');
ylabel('Doppler');
zlabel('Magnitude');
title('Ambiguity Function (3D)');

