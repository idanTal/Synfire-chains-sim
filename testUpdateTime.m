% testUpdateTime

numIterations=1000;

% start of SFCs

p1 = connections(:,sfc(1,1));
fewPools1 = repmat(p1,1,3);
for ii=1:3
    fewPools1(:,ii) = connections(:,sfc(1,1)+ii-1);
end

p2 = connections(:,sfc(1,2));
fewPools2 = repmat(p2,1,3);
for ii=1:3
    fewPools2(:,ii) = connections(:,sfc(1,2)+ii-1);
end

p3 = connections(:,sfc(1,3));
fewPools3 = repmat(p3,1,3);
for ii=1:3
    fewPools3(:,ii) = connections(:,sfc(1,3)+ii-1);
end

p4 = connections(:,sfc(1,4));
fewPools4 = repmat(p4,1,3);
for ii=1:3
    fewPools4(:,ii) = connections(:,sfc(1,4)+ii-1);
end

% stimulus parameters
I0 = -0.2e-9; % external stimulus
tStim = 50 +150*(0:7);  % make the interval longer then refractory period
stimDur = 70;
recordSpikes = true;
showEPSP=false;
showWaves=false;
numWaves=1;
if recordSpikes
    whichSpikes = cell(1,numIterations);
end
tic
EPSP=zeros(1,350);
nFire=zeros(1,numIterations);
for ii=1:numIterations
    updateneurons
    if ~showEPSP
        updateFired
    end
    
    if showEPSP %% generate an EPSP at step 700
        if ii==numIterations-300
            iupN = ampN;
            idwnN= ampN;
        end
        if ii>numIterations-350
            EPSP(ii-numIterations+350) = mean(vN);
        end
    end
    
    if showWaves %% generate K synfire waves
        if numWaves>=1  % excite sfc#1 for 2 ms
            if ii==tStim(1)
                iextN(reshape(fewPools1,1,3*W))=I0;
            elseif ii==tStim(1) +stimDur
                iextN(reshape(fewPools1,1,3*W))=0;
            end
        end

        if numWaves>=2  % excite sfc#2 for 2 ms
            if ii==tStim(2)
                iextN(reshape(fewPools2,1,3*W))=I0;
            elseif ii==tStim(2) +stimDur
                iextN(reshape(fewPools2,1,3*W))=0;
            end
        end

        if numWaves>=3  % excite sfc#3 for 2 ms
            if ii==tStim(3)
                iextN(reshape(fewPools3,1,3*W))=I0;
            elseif ii==tStim(3) +stimDur
                iextN(reshape(fewPools3,1,3*W))=0;
            end
        end

        if numWaves>=4  % excite sfc#4 for 2 ms
            if ii==tStim(4)
                iextN(reshape(fewPools4,1,3*W))=I0;
            elseif ii==tStim(4) +stimDur
                iextN(reshape(fewPools4,1,3*W))=0;
            end
        end

        %% activate waves again
        if numWaves>=5  % excite sfc#1 for 2 ms
            if ii==tStim(5)
                iextN(reshape(fewPools1,1,3*W))=I0;
            elseif ii==tStim(5) +stimDur
                iextN(reshape(fewPools1,1,3*W))=0;
            end
        end

        if numWaves>=6  % excite sfc#2 for 2 ms
            if ii==tStim(6)
                iextN(reshape(fewPools2,1,3*W))=I0;
            elseif ii==tStim(6) +stimDur
                iextN(reshape(fewPools2,1,3*W))=0;
            end
        end

        if numWaves>=7  % excite sfc#2 for 2 ms
            if ii==tStim(7)
                iextN(reshape(fewPools3,1,3*W))=I0;
            elseif ii==tStim(7) +stimDur
                iextN(reshape(fewPools1,3,3*W))=0;
            end
        end

        if numWaves>=8  % excite sfc#2 for 2 ms
            if ii==tStim(8)
                iextN(reshape(fewPools4,1,3*W))=I0;
            elseif ii==tStim(8) +stimDur
                iextN(reshape(fewPools1,4,3*W))=0;
            end
        end
    end

    nFire(ii) = length(fired);
    if recordSpikes
        whichSpikes{ii}=fired;
    end
    if nFire(ii)>400
        disp('Too much')
    end
    
end
toc
