% prepare4plot
% script to prepare the frames on which to plot sfc activity

%% conditions
plotSfc = true;   % set these two flags according to 
plotAnat = true;  % the type of plot you wnat to get
numSfc = size(sfc,2);
numOn = nDelay+5;

%% frame for anatomical plot
if plotAnat
    hight=200;
    width = ceil(N/hight);
    fhA=figure;
    llh = line([0,width],[0,hight],'Marker','.' , 'LineStyle','none');
    aH=gca;
    %% initialize line handels
    xData=cell(1,numOn);
    yData=cell(1,numOn);
    lHA=zeros(1,numOn);
    pIndx = 1;
    for ii=1:numOn
        xData{ii} = [0,width];
        yData{ii} = [0,hight];
        lHA(ii) = line(xData{ii},yData{ii},'LineStyle','none','marker','.','MarkerSize',4,'color',[1,1,1]);
    end
    for ii=1:numOn
        set(lHA(ii),'xData',[],'yData',[])
    end
    delete (llh);
    set(aH,'XLim',[-1,width+1]);
    set(aH,'YLim',[-1,hight+1]);
    hold on
    set(aH,'Color',[0,0,0])
    set(aH,'XTick',[]);
    set(aH,'YTick',[]);
    set(aH,'Position' , [0.01 0.01 0.98 0.92])
    fPosA = get(fhA,'Position');
    fPosA = [5, fPosA(2),fPosA(3)*width/hight,fPosA(4)];
    set(fhA,'Position',fPosA)
    %% set the user menue
    h_PauseA=uimenu(fhA, 'Label','&Pause');
    set(h_PauseA, 'CallBack','pausePlot(gcf);');
    set(h_PauseA,'Enable' ,'on')
    h_ContA=uimenu(fhA, 'Label','&Cont');
    set(h_ContA, 'CallBack','contPlot(gcf);');
    set(h_ContA,'Enable' ,'off')
    h_StopA=uimenu(fhA, 'Label','&Stop');
    set(h_StopA, 'CallBack','stopPlot(gcf);');
    set(h_StopA,'Enable' ,'on')
end

%% make the frame for synfire plot
if plotSfc
    fH=figure;
    % numIterations = length(whichSpikes);
    plot([1,P/M],[0,numSfc*(W+3)]);
    delete(get(gca,'child'));
    aH=gca;
    set(gca,'XLim',[1,P/M]);
    set(gca,'YLim',[0,numSfc*(W+3)]);
    set(gca,'Color',[0,0,0])
    hold on
    tH = text(P/M-10,1.015*numSfc*(W+3),'0');

    for ii=1:numSfc-1
        line([1,P/M],[ii*(W+3)-1 , ii*(W+3)-1], 'color',[1,1,1])
    end
    for ii=1:numSfc
        text(-5,(W+3)*(ii-1)+W/2,num2str(ii));
    end
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(gca,'Position' , [0.03 0.03 0.95 0.9])
    fPos = get(gcf,'Position');
    if ~exist('fPosA', 'var'), fPosA = [5, 162, 200,504]; end
    set(gcf,'Position',[fPosA(1)+fPosA(3)+8,fPos(2), 768 ,fPos(4)])

    %% initialize line handels
    xData=cell(1,numOn);
    yData=cell(1,numOn);
    lH=zeros(1,numOn);
    pIndx = 1;
    for ii=1:numOn
        xData{ii} = ceil(1000*rand(1,5));
        yData{ii} = ceil(200*rand(1,5));
        lH(ii) = line(xData{ii},yData{ii},'LineStyle','none','marker','.','MarkerSize',4,'color',[1,1,1]);
    end
    for ii=1:numOn
        set(lH(ii),'xData',[],'yData',[])
    end
    
    %% make a mark and erase it to leave a handle
    mH = line(10,10, 'Marker','o', 'Color','c' ,'MarkerSize',5 ,...
        'LineStyle','none');
    set(mH,'XData',[] , 'YData',[]);

    %% set the user menue
    h_Pause=uimenu(fH, 'Label','&Pause');
    set(h_Pause, 'CallBack','pausePlot(gcf);');
    set(h_Pause,'Enable' ,'on')
    h_Cont=uimenu(fH, 'Label','&Cont');
    set(h_Cont, 'CallBack','contPlot(gcf);');
    set(h_Cont,'Enable' ,'off')
    h_Stop=uimenu(fH, 'Label','&Stop');
    set(h_Stop, 'CallBack','stopPlot(gcf);');
    set(h_Stop,'Enable' ,'on')
    h_Mark=uimenu(fH, 'Label','&Mark');
    set(h_Mark, 'CallBack','markPlot(gcf);');
    set(h_Mark,'Enable' ,'on')
    h_Clear=uimenu(fH, 'Label','Clea&r');
    set(h_Clear, 'CallBack','clearPlot(gcf);');
    set(h_Clear,'Enable' ,'off')

end


%% set the data
fData = struct('pauseH',[] , 'contH',[] , 'run',true ,...
    'stop',false , 'plotsH',[] , 'plotaH',[] ,'stopHA',[], ...
    'pauseHA',[] , 'contHA',[] , 'stopH',false, ...
    'markH',[] , 'clearH',[] , 'mData',[], 'axH',aH);
if plotSfc
    fData.plotsH= fH;
    fData.pauseH = h_Pause;
    fData.contH = h_Cont;
    fData.stopH = h_Stop;
    fData.markH = h_Mark;
    fData.clearH = h_Clear;
    fData.mData = mH;
    aData = struct('lineH',lH, 'sfcStruct',whereInsfc , 'W',W);
    set(aH,'UserData',aData)
end
if plotAnat
    fData.plotaH= fhA;
    fData.pauseHA = h_PauseA;
    fData.contHA = h_ContA;
    fData.stopHA = h_StopA;
end
if plotSfc
    set(fH,'UserData',fData);
end
if plotAnat
    set(fhA,'UserData',fData);
end

