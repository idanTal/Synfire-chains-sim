% poolAssignment
% script to assign N neurons to P pools of width W
% N, P, W must be defined before starting this procedure
% if s is defined it is used as the seed for random numbers


%% initialize
if ~exist('s','var'), s=[]; end
if isempty(s)
    s=rand('twister');
end
rand('twister',s);
rand(1,10000);  % roll the dice a little

R=10;  % Min distance between two pools with the same neuron
connections = uint16(zeros(W,P));
poolsPerN = ceil(P*W/N);
needed = W*ones(1,P);
cumS = cumsum(needed);
cumS = cumS/cumS(end);  % normalize
whichP=rand(poolsPerN,N);
whichP=sort(whichP);
wp = zeros(1,P);

%% assign neurons to pools such that each neuron is in poolsPerN pools; and
%% each pool contains W neurons
tooClose=0;
% tic
for n=1:N  % for each neuron
    p = whichP(:,n);
    % find to which assign
    pool = zeros(1,poolsPerN);
    for pn = 1:poolsPerN
        pool(pn) = find(cumS>p(pn),1);
    end
    numTries=0;
    while min(diff(pool))<R
        numTries = numTries +1;
        if numTries>10, break; end
        p = sort(rand(poolsPerN,1)); % try again
        for pn = 1:poolsPerN
            pool(pn) = find(cumS>p(pn),1);
        end
    end
    if numTries>10
        tooClose = tooClose +1;
        disp(['too close n=' num2str(n) ', pools: ' num2str(pool)])
    end
    for pn = 1:poolsPerN
        k = pool(pn);
        wp(k) = wp(k)+1;
        needed(k) = needed(k)-1;
        connections(wp(k),k)=n;
    end
    cumS = cumsum(needed);
    cumS = cumS/cumS(end);  % normalize
end
% toc