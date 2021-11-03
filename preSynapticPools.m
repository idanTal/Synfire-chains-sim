function inputPools = preSynapticPools(connections, sfc, N)
% find for each cell who are its presynaptic pools


inputPools = cell(1,N);
for nNo = 1:N
    whichPools = whereIs(connections, nNo);
    % exclude first pools in SFCs
    toExclude = false(1,length(whichPools));
    for pNo = 1:length(whichPools)
        thisPool= whichPools(pNo);
        if isFirstPool(sfc,thisPool)
            toExclude = true;
        end
    end
    whichPools(toExclude) = []; % delete those which are first pools
    inputPools{nNo} = whichPools;
end

return
