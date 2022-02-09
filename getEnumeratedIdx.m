function [sorted_idx, previous_idx] = getEnumeratedIdx(a)
    [~, sorted_idx] = sort(a);
    [~, previous_idx] = sort(sorted_idx);
end