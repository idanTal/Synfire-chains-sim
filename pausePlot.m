function pausePlot(fH)
% A callback procedure from plotSpikes

% fData = struct('pauseH',[] , 'contH',[] , 'run',[]);
fData = get(fH, 'UserData');
fData.run = false;
% coordinate with the other graph
spkH = fData.plotsH;
anatH = fData.plotaH;
if ~isempty(spkH)
    set(fData.pauseH, 'Enable', 'off')
    set(fData.contH, 'Enable','on');
    set(spkH, 'UserData',fData)
end
if ~isempty(anatH)
    set(fData.pauseHA, 'Enable', 'off')
    set(fData.contHA, 'Enable','on');
    set(anatH, 'UserData',fData)
end

return
