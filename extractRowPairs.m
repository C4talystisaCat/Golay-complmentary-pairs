function pairs = extractRowPairs(matrix)
    [rows, ~] = size(matrix);
    pairs = cell(rows*(rows-1)/2, 2); % Initialize cell array to store pairs
    idx = 1;
    for i = 1:rows
        for j = i+1:rows
            pairs{idx, 1} = matrix(i,:);
            pairs{idx, 2} = matrix(j,:);
            idx = idx + 1;
        end
    end
end
