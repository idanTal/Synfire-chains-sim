function whichPools = whereIs(connections, n)
% In which pools neuron N takes part

% global connections sfc N P W
[I,J] = find(connections==n);
whichPools =unique(J);

return
