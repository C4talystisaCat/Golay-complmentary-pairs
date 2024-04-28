function complex_sequence = convert_to_complex(sequence,q)
    % 获取序列的维度
    [rows, cols] = size(sequence);

    
    % 初始化存储映射后的复数序列的数组
    complex_sequence = zeros(rows, cols);
    
    % 对每个元素进行映射
    for i = 1:rows
        for j = 1:cols
            % 获取当前元素
            number = sequence(i, j);
            
            % 计算每个数字在复数圆上的相应位置
            theta = 2 * pi * number / (q);
            complex_sequence(i, j) = exp(1i * theta);
        end
    end
end
