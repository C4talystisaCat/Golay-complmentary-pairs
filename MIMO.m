PRI = 0.01;
PRF = 1 / PRI;
theta = 0.15;
symbol_rate=10;
sampling_rate=1000;
t = PRI * symbol_rate;
f = [1,2,1,0,1,0,1,2,1,2,1,0,1,2,3,2,1,0,3,0,1,0,1,2];
g = [1,2,1,0,1,0,1,2,3,0,3,2,1,2,3,2,1,0,3,0,3,2,3,0];
q=4;
% 相位偏移
phases = [0 pi/2 pi 3*pi/2]; 

signalA = generate_nary_code(f, phases, q, symbol_rate, sampling_rate);
signalB = generate_nary_code(g, phases, q, symbol_rate, sampling_rate);

% 定义每个天线发送的波形
Tx0 = [signalA; signalB; signalB; signalA]; % T_0 (0)={x,y,y,x}
Tx1 = [signalB; signalA; signalA; signalA]; % T_1 (3)={y,x,x,y}
Tx2 = [signalB; signalB; signalA; signalA]; % T_2 (5)={y,x,x,y}
Tx3 = [signalA; signalB; signalB; signalA]; % T_3 (8)={x,y,y,x}

% 计算每个天线的延迟长度
delays = [0 3 5 8] * PRI * sampling_rate;

% 计算组合波形的总长度，考虑所有天线发送的波形的最大长度和最大延迟
total_length = max(length(signalA), length(signalB)) + max(delays);

% 初始化组合波形
combined_signal = zeros(1, total_length);

% 分别对每个天线的信号进行延迟并叠加到组合波形上
for i = 1:4
    % 计算当前天线信号的长度
    tx_length = size(Tx0, 2);
    
    % 在延迟处将当前天线的信号加到组合波形上
    combined_signal(1+delays(i):tx_length+delays(i)) = combined_signal(1+delays(i):tx_length+delays(i)) + Tx0(i,:);
    combined_signal(1+delays(i):tx_length+delays(i)) = combined_signal(1+delays(i):tx_length+delays(i)) + Tx1(i,:);
    combined_signal(1+delays(i):tx_length+delays(i)) = combined_signal(1+delays(i):tx_length+delays(i)) + Tx2(i,:);
    combined_signal(1+delays(i):tx_length+delays(i)) = combined_signal(1+delays(i):tx_length+delays(i)) + Tx3(i,:);
end

% 绘制组合波形
t_combined = (0:total_length-1) / sampling_rate; % 时间向量
figure;
plot(t_combined, real(combined_signal)); % 绘制组合波形的实部
xlabel('Time (s)');
ylabel('Amplitude');
title('Combined Signal');




% 计算组合波形的总长度，考虑所有天线发送的波形的最大长度和最大延迟
total_length = max(length(signalA), length(signalB)) + max(delays);

% 初始化组合波形
combined_signal = zeros(1, total_length);

% 分别对每个天线的信号进行延迟并叠加到组合波形上
for i = 1:4
    % 获取当前天线的波形
    tx_waveform = [Tx0(i,:); Tx1(i,:); Tx2(i,:); Tx3(i,:)];
    
    % 计算当前天线信号的长度
    tx_length = size(tx_waveform, 2);
    
    % 在延迟处将当前天线的信号加到组合波形上
    combined_signal(1+delays(i):tx_length+delays(i)) = combined_signal(1+delays(i):tx_length+delays(i)) + sum(tx_waveform);
end

% 绘制组合波形
t_combined = (0:total_length-1) / sampling_rate; % 时间向量
figure;
plot(t_combined, real(combined_signal)); % 绘制组合波形的实部
hold on;

% 在同一图上叠加绘制每个天线的波形
for i = 1:4
    plot(t_combined(1+delays(i):tx_length+delays(i)), real(sum([Tx0(i,:); Tx1(i,:); Tx2(i,:); Tx3(i,:)])), '--'); % 绘制每个天线的波形
end

xlabel('Time (s)');
ylabel('Amplitude');
title('Combined Signal and Individual Waveforms');
legend('Combined Signal', 'Tx0', 'Tx1', 'Tx2', 'Tx3');
hold off;


%%
theta=0.3;
freq = theta / (2 * pi * t);
[afmag_combined, delay_combined, doppler_combined] = ambgfun(combined_signal, sampling_rate, PRF);

% 绘制模糊函数网格包络图像
figure;
surf(delay_combined, doppler_combined, afmag_combined, 'EdgeColor', 'interp', 'FaceColor', 'interp');
xlabel('Delay index');
ylabel('Doppler shift(rad) ');
zlabel('Amplitude');
title('Ambiguity Function of Combined Signal');
ylim([-freq,0]);
view(150,30)
%%
theta=0.15;
freq = theta / (2 * pi * t);
% 设置 xlim 和 ylim
xlim([min(delay_combined), max(delay_combined)]);
ylim([-freq,0]);

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
[ambcut, delay_combined] = ambgfun(combined_signal, sampling_rate, PRF, "Cut", "Doppler", "CutValue", freq);

figure;
imagesc(delay_combined, delay_combined, abs(ambcut));
title('Ambiguity Function at θ = 0.15');
xlabel('Delay index');
ylabel('Doppler shift index');
colorbar;
%%

% 绘制带有限制多普勒轴范围的图像
figure;
imagesc(delay_combined,doppler_combined, abs(ambcut));
title('Ambiguity Function ');
xlabel('Delay index');
ylabel('Doppler shift index');
colorbar;
%%
% 定义给定的 theta 值
theta_values = [0, 0.05, 0.15, 0.3];

% 初始化存储不同 theta 值下的模糊函数
ambcut_values = cell(length(theta_values), 1);
delay_combined_values = cell(length(theta_values), 1);

% 初始化图例
legend_strings = cell(length(theta_values), 1);

% 计算并绘制每个 theta 值对应的模糊函数
figure;
hold on;
for i = 1:length(theta_values)
    theta = theta_values(i);
    t = PRI * symbol_rate;
    freq = theta / (2 * pi * t);
    [ambcut, delay_combined] = ambgfun(combined_signal, sampling_rate, PRF, "Cut", "Doppler", "CutValue", freq);
    ambcut_values{i} = ambcut;
    delay_combined_values{i} = delay_combined;
    plot(delay_combined, ambcut, 'LineWidth', 1.5);
    legend_strings{i} = ['θ=', num2str(theta)];
end
hold off;
title('Ambiguity Function for Given θ Values');
xlabel('Delay index');
ylabel('Amplitude');
legend(legend_strings);
%%
ambgfun(combined_signal, sampling_rate, PRF)
