function connectTo = preSynaptic(connections,sfc,n)
% find which neurons are activated by N


%% initialize
% global connections sfc N P W
whichPools = whereIs(connections,n);
if isempty(whichPools)
    connectTo = [];
    return
else
    N = max(max(connections));
    if N>=2^16-1
        error('MATLAB:SFC:tooManyNeurons','Present net can support at most 64k neurons')
    end
    connectTo = zeros(1,N);
end
W = size(connections,1);
i1=1;

%% find connections
for pNo = 1:length(whichPools)
    thisPool= whichPools(pNo);
    if ~isLastPool(sfc,thisPool)
        nextN = connections(:,thisPool+1);
        connectTo(i1:i1+W-1) = nextN;
        i1 = i1+W;
    end
end


%% wrap
connectTo(connectTo==0)=[];
connectTo = unique(connectTo);
connectTo = uint16(connectTo);

return