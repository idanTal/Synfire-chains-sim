function isFirst =isFirstPool(sfc, n)
% is pool no. N the first pool in a chain

% global connections sfc N P W
k = find(sfc(1,:)==n,1);
isFirst = ~isempty(k);

return
