function normalized = normalize(matrix)
    normalized = matrix - mean(matrix, 1);
    normalized = normalized ./ sqrt(var(matrix, 1));
end