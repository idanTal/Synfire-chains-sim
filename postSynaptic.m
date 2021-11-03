function connectFrom = postSynaptic(connections,sfc,n)
% find which neurons are activated by N


%% initialize
% global connections sfc N P W
whichPools = whereIs(connections,n);
if isempty(whichPools)
    connectFrom = [];
    return
else
    N = max(max(connections));
    if N>=2^16-1
        error('MATLAB:SFC:tooManyNeurons','Present net can support at most 64k neurons')
    end
    connectFrom = zeros(1,N);
end
W = size(connections,1);
i1=1;

%% find connections
for pNo = 1:length(whichPools)
    thisPool= whichPools(pNo);
    if ~isFirstPool(sfc,thisPool)
        prevN = connections(:,thisPool-1);
        connectFrom(i1:i1+W-1) = prevN;
        i1 = i1+W;
    end
end


%% wrap
connectFrom(connectFrom==0)=[];
connectFrom = unique(connectFrom);
connectFrom = uint16(connectFrom);

return