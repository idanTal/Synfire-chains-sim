% plotSpikes
% script to plot spikes from which spikes as a dynamic dot display

if plotAnat
    figure(fhA)
end
if plotSfc
    figure(fH)
end
for step = 1:numIterations
    fired = whichSpikes{step};
    if plotSfc
        fData=get(fH,'UserData');
        if fData.stop
            break
        end
        if ~isempty(fired)

            % compute their xy position
            numSpikes = length(fired);
            xData = zeros(1,4*numSpikes);
            yData = zeros(1,4*numSpikes);
            for spike =1:numSpikes
                sNo = fired(spike);
                ddI = 1 +4*(spike-1);
                sfcNo = whereInsfc.sfcNo(sNo,:); % what if more then one?
                poolNo = whereInsfc.poolNo(sNo,:);
                whereInPool = whereInsfc.whereInPool(sNo,:);
                xData(ddI:ddI+3)= poolNo+1;
                yData(ddI:ddI+3) = (W+3)*(sfcNo-1)+1 +whereInPool;
            end
            % plot them
            set(lH(pIndx), 'Xdata', xData , 'yData',yData)
            set(tH, 'String', num2str(1000*step*tD))
            drawnow
        end  % end of plotSfc and Fired not empty
    end   % end of plotSfc
    if plotAnat
        fData=get(fhA,'UserData');
        if fData.stop
            break
        end
        if ~isempty(fired)
            xData = floor(fired/hight);
            yData = fired- hight*xData;
            set(lHA(pIndx), 'Xdata', xData , 'yData',yData)
            %             for spike =1:numSpikes
            %                 sNo = fired(spike);
            %                 xData = rem(sNo,hight);
            %             end
        end
    end
        
    if plotSfc
        fData=get(fH,'UserData');
    else
        fData=get(fhA,'UserData');
    end
    while ~fData.run  % wait till user presses cont
        pause(0.01)
        fData=get(gcf,'UserData');
        if fData.stop
            break
        end
    end
    pause(0.01)
    if fData.stop
        break
    end
    % advance the index
    pIndx = pIndx+1;
    if pIndx>nDelay+5, pIndx=1; end

end
