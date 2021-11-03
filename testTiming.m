% testTiming
% test how long it takes to find all outputs of N neurons

% CONCLUSIONS
% 1.  When run as procedure calling procedure etc..  251 s.
% 2.  When all variables are global                  231 s.
% 3.  When script with no calls to procedure         165 s.
%  NOT PRACTICAL for a BIG NETWORK
% if just the list of presynaptic pools is kept for each neuron then it
% takes 12 to 24 s to get all connections (24 s. id a unique input list is
% made.
%  for 1 sec of real time with 0.1 ms steps it would take 120,000 s =46
%  hours.

tic
% for nNo = 1:40000
% %     connectTo = preSynaptic(nNo);
% whichPools = whereIs(nNo);
% if isempty(whichPools)
%     connectTo = [];
%     return
% else
%     connectTo = zeros(1,N);
% end
% % W = size(connections,1);
% i1=1;
% 
% %% find connections
% for pNo = 1:length(whichPools)
%     thisPool= whichPools(pNo);
%     % if ~isLastPool(thisPool)
%     if ~isempty(find(sfc(2,:)==pNo,1))
%         nextN = connections(:,thisPool+1);
%         connectTo(i1:i1+W-1) = nextN;
%         i1 = i1+W;
%     end
% end
% 
% 
% %% wrap
% connectTo(connectTo==0)=[];
% connectTo = unique(connectTo);
%
blank = zeros(1,N);
for nNo = 1:40000
    i1=1;
    whichPools = inputPools{nNo};
    connectTo = blank;
    for pNo = 1:length(whichPools)
        thisPool= whichPools(pNo);
        prevN = connections(:,thisPool-1);
        connectTo(i1:i1+W-1) = prevN;
        i1 = i1+W;
    end
    connectTo(i1:end)=[];
    connectTo = unique(connectTo);
end
toc
