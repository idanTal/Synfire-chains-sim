function [connections,s] = makePools(N,P,W,s)
% distribute N neurons in P pools of width W.


% the code comented below was replaced by
poolAssignment

% if ~exist('s','var'), s=[]; end
% if isempty(s)
%     s=rand('twister');
% else
%     rand('twister',s);
% end
% 
% connections=ceil(N*rand(W,P));
% % check for repeating the same neuron in the same pool
% for ii = 1:P
%     [U,I,J] = unique(connections(:,ii));
%     while length(I)<W
%         A = ceil(N*rand(W-length(I),1));
%         [U,I,J] = unique([U;A]);
%     end
%     connections(:,ii)=U;
% end
% 
% connections = uint16(connections);
return
