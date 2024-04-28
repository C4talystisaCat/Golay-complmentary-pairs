m=5;
q=4;
[F,G]=GDJ_GCP(m,q);

f=F(1,:);
g=G(1,:);
phases = [0 pi/2 pi 3*pi/2]; % 每个相位对应的相位值（这里示例为 0、π/2、π、3π/2）
% 进制数为 4
symbol_rate = 10; % 符号速率为 10 符号/秒
sampling_rate = 1000; % 采样率为 100
% 生成信号
signalA = generate_nary_code(f, phases, q, symbol_rate, sampling_rate);
signalB = generate_nary_code(f, phases, q, symbol_rate, sampling_rate);
PRF=400;
% 绘制信号波形
t = (0:length(signalB)-1) / sampling_rate; % 时间向量
figure;
plot(t, real(signalB)); % 绘制信号的实部
xlabel('Time (s)');
ylabel('Amplitude');
title('Generated N-ary Coded Signal');

%发射信号波形
TX=[signalA,signalB,signalA,signalB,signalA,signalB];
%%
% 计算模糊函数
[afmag, delay, doppler] = ambgfun(TX, sampling_rate, PRF);

% 绘制模糊函数网格包络图像
figure;
surf(delay, doppler, afmag, 'EdgeColor', 'interp', 'FaceColor', 'interp');
xlabel('Delay index');
ylabel('Doppler shift (rad)');
zlabel('Amplitude');
title('Ambiguity Function');

% 设置 xlim 和 ylim
xlim([-1.5,1.5]);
ylim([-0.15,0]);
view(-215,30);

%%
%绘制截面

CUT=1;
[ambcut,delay]=ambgfun(TX,sampling_rate,PRF,"cut","Delay","CutValue",CUT);
% 将模糊函数幅度转换为 dB 单位
ambcut_dB = 10 * log10(abs(ambcut));
% 绘制结果
figure;
plot(delay, ambcut_dB); % 使用 plot 函数绘制二维图像
xlabel('Delay index');
ylabel('Amplitude (dB)');
title('Ambiguity Function Along Doppler Plane');

%%
% 计算模糊函数
[afmag, delay, doppler] = ambgfun(TX, sampling_rate, PRF);

afmag_dB=20*log10(afmag);
% 绘制模糊函数网格包络图像
figure;
surf(delay, doppler, afmag_dB, 'EdgeColor', 'interp', 'FaceColor', 'interp');
xlabel('Delay index');
ylabel('Doppler shift (rad)');
zlabel('Amplitude');
title('Ambiguity Function');

% 设置 xlim 和 ylim
xlim([-1.5,1.5]);
ylim([-0.15,0]);
view(-215,30);