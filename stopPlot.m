function stopPlot(fH)
% A callback procedure from plotSpikes

% fData = struct('pauseH',[] , 'contH',[] , 'run',[]);
fData = get(fH, 'UserData');
fData.stop = true;
% coordinate with the other graph
spkH = fData.plotsH;
anatH = fData.plotaH;
if ~isempty(spkH)
    set(fData.pauseH, 'Enable', 'off')
    set(fData.contH, 'Enable','off');
    set(fData.stopH, 'Enable','off');
    set(spkH, 'UserData',fData)
end
if ~isempty(anatH)
    set(fData.pauseHA, 'Enable', 'off')
    set(fData.contHA, 'Enable','off');
    set(fData.stopHA, 'Enable','off');
    set(anatH, 'UserData',fData)
end

return
