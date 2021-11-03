function [dEpsc, epsc, T, qDwn, qUp, Amp] = makeEpsc(t1, t2, dt)
% make the shape of EPSC as difference between two exponentilas
% [dEpsc, epsc, T, q] = makeEpsc(t1, t2, dt);
% t1    - ~rise time constant
% t2    - decay time constant, t2 must be bigger then t1
% dt    - time step for simulation
% 
% dEpsc - is such that if the current of a neuron is updated by:
%         I(t+1) = q*I(t) + dEpsc(t+1) 
%         the epsc will be exactly reconstructed
% epsc  - shape of epsc, normalized so the peak is 1
% T     - array with times for which epsc is computed
% qDwn  - decay factor
% qUp   - decay of rising phase
% Amp   - amplitude of original exponentials
% 
% NOTE after ~2*t2 the simple update" epsc(t=1) = q*epsc(t) is quite
%      accurate


%% make the epsc
T=0:dt:5*t2;
epsc = exp(-T/t2) - exp(-T/t1);
Amp = 1/max(epsc);
epsc = Amp*epsc;

% get the decay factors
n1 = t1/dt;
qUp =exp(-1/n1);
n2 = t2/dt;
qDwn=exp(-1/n2);

%% compute Delta so that when added to I of neuron the epsc will be
%% reconstructed
dEpsc = zeros(size(epsc));
for ii=2:length(epsc)
    dEpsc(ii) = epsc(ii) - epsc(ii-1)*qDwn;
end

%% NOTES
% % you may reconstruct epsc by:
% I1 = zeros(size(T));
% I2 = zeros(size(T));
% I1(1) = Amp;
% I2(1) = Amp;
% for ii=2:length(T);
%     I1(ii) = qUp*I1(ii-1);
%     I2(ii) = qDwn*I2(ii-1);
% end
% plot(T,epsc)
% hold on
% plot(T,I2-I1,'r')

return
