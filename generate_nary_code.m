function signal = generate_nary_code(nary_data, phases, N, symbol_rate, sampling_rate)
    % 输入参数：
    % nary_data: N 进制数据序列，例如 [0 1 2 1 0 2]
    % phases: 每个相位对应的相位值（单位：弧度），是一个长度为 N 的向量
    % N: 进制数
    % symbol_rate: 符号速率（单位：符号每秒）
    % sampling_rate: 采样率（单位：采样每秒）

    % 计算符号周期（单位：秒）
    symbol_period = 1 / symbol_rate;

    % 计算每个符号的采样点数
    samples_per_symbol = sampling_rate / symbol_rate;

    % 初始化信号
    signal = [];

    % 遍历 N 进制数据序列
    for i = 1:length(nary_data)
        % 获取当前数据对应的相位
        phase_index = nary_data(i) + 1; % 数据值作为索引，加 1 是因为索引从 1 开始
        phase = phases(phase_index);

        % 生成当前符号的信号
        symbol = exp(1j * phase * ones(1, samples_per_symbol));

        % 将当前符号的信号添加到总信号中
        signal = [signal symbol];
    end

    % 将信号重新采样为目标采样率
    signal = resample(signal, sampling_rate, length(signal));
end
