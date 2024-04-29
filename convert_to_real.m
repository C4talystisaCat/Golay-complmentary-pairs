function sequence = convert_to_real(complex_sequence, q)
    % 获取序列的维度
    [rows, cols] = size(complex_sequence);

    % 初始化存储逆向映射后的实数序列的数组
    sequence = zeros(rows, cols);

    % 对每个复数进行逆向映射
    for i = 1:rows
        for j = 1:cols
            % 获取当前复数
            complex_number = complex_sequence(i, j);

            % 计算当前复数的相角
            theta = angle(complex_number);

            % 将相角映射回实数序列
            number = round((theta * q) / (2 * pi));

            % 处理超出范围的情况
            if number < 0
                number = number + q;
            elseif number >= q
                number = number - q;
            end

            sequence(i, j) = number;
        end
    end
end
