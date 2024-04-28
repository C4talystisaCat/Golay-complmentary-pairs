%list all seq with Z length ZCZ
m = 6;
q = 2;
seq = all_sequence(m,q);
pairs = extractRowPairs(seq);

Z = zeros(1, size(pairs,1)); % 用于存储计数值 Z

disp('Sequence pairs with Z length ZCZ:');
for i = 1:size(pairs, 1)
    f = double(pairs{i, 1});
    g = double(pairs{i, 2});

    % 将序列转换为复数信号
    complex_f = convert_to_complex(f, q);
    complex_g = convert_to_complex(g, q);

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

    % 计算序列右侧一半的0的个数

    half_length = floor((length(C1)+3) / 2);
    % 统计右侧第一个非零元素前的零的个数
    count_C1 = 0;
    for j = half_length:length(C1)
        if C1(j) == 0
            count_C1 = count_C1 + 1;
        else
            break;
        end
    end
    
    count_C2 = 0;
    for j = half_length:length(C2)
        if C2(j) == 0
            count_C2 = count_C2 + 1;
        else
            break;
        end
    end

    % 如果计数大于0，则保存序列对并标注其计数为 Z
    if count_C1 > 0 && count_C2 > 0
        Z(i) = min(count_C1, count_C2); % 记录计数值为 Z
        disp(['Pair ', num2str(i), ': Z = ', num2str(Z(i)), ', f = ', num2str(f), ', g = ', num2str(g)]);
    end
end
