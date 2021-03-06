function sfc = pools2chains(P,M)
% divide P pools into M synfire chains
%
%
% sfc - 2xM matrix with the first and last pool in each chain


%% initialize
sfc=zeros(2,M);
sfc(1,1) = 1; % start chain 1
sfc(2,M) = P; % end of last chain
meanL = round(P/M);

%% divide the rest
for ii = 1:M-1
    end1 = sfc(1,ii)+meanL-1;
    sfc(2,ii) = end1;    % end of previous chain
    strt2 = end1+1;
    sfc(1,ii+1) = strt2; % start of next chain
    meanL = round((P-strt2+1)/(M-ii));
end

%% wrap
sfc = uint16(sfc);

return
