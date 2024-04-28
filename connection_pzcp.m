function [all_pzcp] = connection_pzcp(F, G)
    % 获取矩阵 F 和 G 的行数
    num_rows_F = size(F, 1);
    num_rows_G = size(G, 1);

    all_pzcp = {}; % 用于存储所有的 PZCP

    % 遍历矩阵 F 和 G 的所有行
    for i = 1:num_rows_F
        for j = 1:num_rows_G
            % 获取当前行对应的序列
            f = double(F(i, :));
            g = double(G(j, :));

            % 构造连接后的序列
            e = [f, g];
            f = [f, -g];

            % 添加到结果中
            all_pzcp{end+1} = {e, f};
        end
    end
end
