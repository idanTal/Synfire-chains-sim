% updateneurons
% script to update all neurons in one tD step

% update the iupN and idwnN according to presynaptic neurons that fired
% delay times earlier

% update each neuron
dVdT = (gkN.*(vN-vk0) +gnaN.*(vN-vna0) +gclN.*(vN-vcl0) +idwnN -iupN +inoiseN +iextN)/cN;
vN = vN -tD*dVdT;

gkD = kQ*gkD;
gkN = gk0 +gkD;
gnaD = naQ*gnaD;
gnaN= gna0 +gnaD;
% gclD = clQ*gclD;
% gclN = gcl0 +gclD;  % in anticipation for inhibition
idwnN = idwnN*dwnQ;
iupN = iupN*upQ;
inoiseN = inoiseN*noiseQ + noiseN*randn(1,N);

% find which cells fired
fired = find(vN>=th0);
