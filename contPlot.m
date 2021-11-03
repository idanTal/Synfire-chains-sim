function contPlot(fH)
% A callback procedure from plotSpikes

% fData = struct('pauseH',[] , 'contH',[] , 'run',[]);
fData = get(fH, 'UserData');
set(fData.contH, 'Enable', 'off')
fData.run = true;
% coordinate with the other graph
spkH = fData.plotsH;
anatH = fData.plotaH;
if ~isempty(spkH)
    set(fData.pauseH, 'Enable', 'on')
    set(fData.contH, 'Enable','off');
    set(spkH, 'UserData',fData)
end
if ~isempty(anatH)
    set(fData.pauseHA, 'Enable', 'on')
    set(fData.contHA, 'Enable','off');
    set(anatH, 'UserData',fData)
end



set(fH, 'UserData',fData)
set(fData.pauseH, 'Enable','on');

return
