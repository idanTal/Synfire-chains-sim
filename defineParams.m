% defineParams
% script to define the params and initial values for the simulation
%
% variables ending with N are for single neuron, withS are specific params
% per 1 cm62, with 0 are steady state condition, with D are delta, with T 
% are time constants, with Q are multipliers per step.
%
% All values are in Volts, Ampers, Ohms, seconds, cm^2, Farads
%
% the following variables have to be defined before running:
% N  how many neurons in the network
%
% with initial parameters as below the noise std is 6.7 mV.  Without synaptic
% or external input the membrane potential is -8.7 mv. order of magnitude
% of firing with NO synaptic connections is 0.2 spikes per 0.2 ms. EPSP 
% amplitude ~0.78 mv. Time to peak EPSP ~2.8 ms.


tD = 0.0002;       % 5 steps per ms
delay = 0.002;     % conduction delay between spike and epsp
cS = 1e-6;         % specific capacity in Farad
gkS = 1/2000;      % K conductivity in mho
gnaS=gkS/40;
gclS=gkS;
gkSpkS = 10*gkS;   % change after spike
gnaSpkS = -gnaS;   % zero after spike
gclSpkS = 0;

kT = 0.010;        % restoring gk to its ss value
naT = 0.003;
noiseT = 0.010;    % integrating the noise current
upT = 0.0012;       % rise time of synaptic current
dwnT = 0.003;      % decay time of synaptic current

kQ = exp(-tD/kT);
naQ = exp(-tD/naT);
noiseQ = exp(-tD/noiseT);
[pscD, psc, T, dwnQ, upQ, amp0] = makeEpsc(upT, dwnT, tD);

v0 = -0.010;            % resting membrane potential
th0= 0.016;        % threshold in volts
vk0 = -0.020;      % K equilibrium potential
vna0 = 0.100;
vcl0 = 0;

aN = 1e-5;               % area in square cm = 1000 square um
ampN = -amp0*aN*1e-5/11; % synaptic currnet per synapse
noiseN = aN*1.4*1e-6;    % total synaptic noise per neuron
gkSpkD = aN*gkSpkS;
gnaSpkD = aN*gnaSpkS;
gclSpkD = aN*gclSpkS;
cN = aN*cS;
iupN = zeros(1,N);      % up component of PSC
idwnN = zeros(1,N);     % down component of PSC
iextN = zeros(1,N);     % external stimulating current
inoiseN = zeros(1,N);   % noise current

gk0 = aN*gkS;
gna0 = aN*gnaS;
gcl0 = aN*gclS;
vN = v0*ones(1,N);
vD = zeros(1,N);
gnaD = zeros(1,N);
gkD  = zeros(1,N);
gclD = zeros(1,N);

gkN = gk0*ones(1,N);
gnaN= gna0*ones(1,N);
gclN = gcl0*ones(1,N);

nDelay=ceil(delay/tD) +1; % no of steps in synaptic delay
delayI = 1;
fireHistory=cell(1,nDelay);
