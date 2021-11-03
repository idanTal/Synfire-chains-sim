% buildSFC
% script to start the structure of multiple SFCs in a network

N = 20000;   % No. of excitatory neurons
P = 1600;    % No of pools in the net
W = 50;      % width of each pool
M = 4;       % number of SFCs

[connections,s] = makePools(N,P,W); % add s if you want to start from a certain seed
sfc = pools2chains(P,M);            % divide into M chains of ~ equal length

convergeIn = cell(1,N);
for n = 1:N
    convergeIn{n} = uint16(postSynaptic(connections,sfc,n)); % inputs to n
end
% 
divergeOut = cell(1,N);
for n = 1:N
    divergeOut{n} = uint16(preSynaptic(connections,sfc,n));  % outputs from n
end

%% save results
save SFC2 N P M W s connections sfc
save dOut2 divergeOut
save cIn2 convergeIn

