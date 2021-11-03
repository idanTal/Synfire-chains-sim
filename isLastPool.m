function isLast =isLastPool(sfc, n)
% is pool no. N the last pool in a chain

% global connections sfc N P W
k = find(sfc(2,:)==n,1);
isLast = ~isempty(k);

return