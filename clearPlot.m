function clearPlot(fH)
% A callback procedure from plotSpikes

% fData = struct('pauseH',[] , 'contH',[] , 'run',[]);
fData = get(fH, 'UserData');

%% find which is the closest point
mH = fData.mData;
set (mH, 'XData',[] , 'YData',[]);

set(fData.clearH, 'Enable', 'off')

return
