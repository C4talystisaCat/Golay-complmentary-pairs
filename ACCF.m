function result = ACCF(sequence1, sequence2, q)
    % 将输入序列转换为复数形式
    f = convert_to_complex(sequence1, q);
    g = convert_to_complex(sequence2, q);

    % 计算互相关
    r_fg = xcorr(f, g);
    r_gf = xcorr(g, f);

    % 计算互相关函数的绝对值和
    result = abs(r_fg + r_gf);
end

function complex_sequence = convert_to_complex(sequence, q)
    % 将输入序列转换为复数形式
    % 假设输入序列是一个行向量
    real_part = sequence(1:end/2);
    imag_part = sequence(end/2 + 1:end);
    complex_sequence = complex(real_part, imag_part);
end
