%fucntion explain  L是序列的长度为一个偶数值，q代表该序列是q元的，ZCZ是可选输入值代表返回值中选出ZCZ为某一值的序列对
function result = listallpzcp(L, q, zcz)
    seq = all_sequence(L, q);
    pairs = extractRowPairs(seq);

    Z = zeros(1, size(pairs,1)); % 用于存储计数值 Z

    result = {}; % 用于存储满足条件的序列对

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

        % 如果计数大于0，则保存序列对
        if count_C1 > 0 && count_C2 > 0
            Z(i) = min(count_C1, count_C2); % 记录计数值为 Z
            % 如果未指定目标 Z 值，或者当前 Z 值等于目标 Z 值，则将序列对添加到结果中
            if nargin < 3 || Z(i) == zcz
                result{end+1} = {Z(i), f, g}; % 将满足条件的序列对添加到结果中
            end
        end
    end
end
