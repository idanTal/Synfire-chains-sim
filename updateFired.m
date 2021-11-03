% updateFired

% script to update post synaptic cells
vN(fired)=v0;
gkD(fired) = gkSpkD;
gnaD(fired) = gnaSpkD;
% gclD(fired) = gclSpkD;
fireHistory{delayI}=fired;
delayI = 1+mod(delayI,nDelay);

effectiveFired = fireHistory{delayI};
fireHistory{delayI} = [];

for n=1:length(effectiveFired)
    nNo = effectiveFired(n);
    % add synaptic currents to the post synaptic neurons
    recieveN = divergeOut{nNo};
    iupN(recieveN) = iupN(recieveN) + ampN;
    idwnN(recieveN) = idwnN(recieveN) + ampN;
end
