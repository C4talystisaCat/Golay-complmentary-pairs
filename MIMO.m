% 定义参数
m = 5; % 序列长度
q = 4; % 基数
symbol_rate = 10; % 符号速率为 10 符号/秒
sampling_rate = 1000; % 采样率为 1000 Hz
PRI = 0.01;
PRF = 1 / PRI;

% 生成F,G序列
[F, G] = GDJ_GCP(m, q);

% 提取第一行作为发送序列
f = [1,2,1,0,1,0,1,2,1,2,1,0,1,2,3,2,1,0,3,0,1,0,1,2];
g = [1,2,1,0,1,0,1,2,3,0,3,2,1,2,3,2,1,0,3,0,3,2,3,0];

% 相位偏移
phases = [0 pi/2 pi 3*pi/2]; 

% 生成信号
signalA = generate_nary_code(f, phases, q, symbol_rate, sampling_rate);
signalB = generate_nary_code(g, phases, q, symbol_rate, sampling_rate);

% 计算每个天线的延迟长度
delays = [0 3 5 8] * PRI * sampling_rate;

% 计算组合波形的总长度
total_length = max(length(signalA), length(signalB)) + max(delays);

% 初始化组合波形
combined_signal = zeros(1, total_length);

% 发射信号波形
Tx = {signalA, signalB, signalB, signalA}; % 存储每个天线信号
for i = 1:4
    delay_samples = round(delays(i));
    combined_signal(1+delay_samples:delay_samples+length(Tx{i})) = ...
        combined_signal(1+delay_samples:delay_samples+length(Tx{i})) + Tx{i};
end

% 绘制组合波形
t_combined = (0:total_length-1) / sampling_rate; % 时间向量
figure;
plot(t_combined, real(combined_signal)); % 绘制组合波形的实部
xlabel('Time (s)');
ylabel('Amplitude');
title('Combined Signal');
%%
% 计算模糊函数
[afmag_combined, delay_combined, doppler_combined] = ambgfun(combined_signal, sampling_rate, PRF);

% 绘制模糊函数网格包络图像
figure;
surf(delay_combined, doppler_combined, afmag_combined, 'EdgeColor', 'interp', 'FaceColor', 'interp');
xlabel('Delay index');
ylabel('Doppler shift (rad)');
zlabel('Amplitude');
title('Ambiguity Function of Combined Signal');

% 设置 xlim 和 ylim
xlim([min(delay_combined), max(delay_combined)]);
ylim([-0.15,0]);

view(0,90)


theta=0.15;
t=PRI*symbol_rate;
freq=theta/(2*pi*t);
[ambcut,delay_combined] = ambgfun(combined_signal, sampling_rate, PRF,"Cut","Doppler","CutValue",freq);

figure;
plot(delay_combined,ambcut)
title('Ambiguity Function at θ=0.15');
xlabel('Delay index');
ylabel('Amplitude');
colorbar


theta=0.05;
t=PRI*symbol_rate;
freq=theta/(2*pi*t);
[ambcut,delay_combined] = ambgfun(combined_signal, sampling_rate, PRF,"Cut","Doppler","CutValue",freq);

figure;
plot(delay_combined,ambcut)
title('Ambiguity Function at θ=0.05');
xlabel('Delay index');
ylabel('Amplitude');
colorbar
%%
theta = 0.15;
t = PRI * symbol_rate;
freq = theta / (2 * pi * t);
[ambcut, delay_combined] = ambgfun(combined_signal, sampling_rate, PRF, "Cut", "Doppler", "CutValue", freq);

figure;
imagesc(delay_combined, delay_combined, abs(ambcut));
title('Ambiguity Function at θ = 0.15');
xlabel('Delay index');
ylabel('Doppler shift index');
colorbar;

theta = 0.05;
t = PRI * symbol_rate;
freq = theta / (2 * pi * t);
[ambcut, delay_combined] = ambgfun(combined_signal, sampling_rate, PRF, "Cut", "Doppler", "CutValue", freq);

figure;
imagesc(delay_combined, delay_combined, abs(ambcut));
title('Ambiguity Function at θ = 0.05');
xlabel('Delay index');
ylabel('Doppler shift index');
colorbar;

