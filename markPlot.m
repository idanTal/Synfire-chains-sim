function markPlot(fH)
% A callback procedure from plotSpikes

% fData = struct('pauseH',[] , 'contH',[] , 'run',[]);
fData = get(fH, 'UserData');
% coordinate with the other graph
spkH = fData.plotsH;
anatH = fData.plotaH;
aH = fData.axH;  % handle for axis
%% get the point from the user
[x,y] = ginput(1);
if isempty(x), return; end

%% find which is the closest point
aData = get(aH,'UserData');
lH = aData.lineH;
whereInsfc = aData.sfcStruct;
mH = fData.mData;
W = aData.W;

xD= cell(length(lH));
for ii = 1:length(lH)
    xData = get(lH(ii),'xData');
    yData = get(lH(ii),'yData');
    xD{ii} = [xData; yData];
end
% concatenate all to find which cell is it
XY = cat(2,xD{:});
absD = abs(XY(1,:)-x) + abs(XY(2,:)-y);
indx = find(absD==min(absD),1);
x0 = XY(1,indx);
y0 = XY(2,indx);
sfcNo=1+floor(y0/(W+3));
poolNo = x0-1;
whereInPool=y0-(sfcNo-1)*(W+3)-1;
whoIs = whereInsfc.sfcNo==sfcNo & whereInsfc.poolNo==poolNo...
    & whereInsfc.whereInPool==whereInPool;
[I,J] = find(whoIs);
sNo=I(1);  % this is the spike No.
%plot it
sfcNo = whereInsfc.sfcNo(sNo,:); % what if more then one?
poolNo = whereInsfc.poolNo(sNo,:);
whereInPool = whereInsfc.whereInPool(sNo,:);
xData(1:4)= poolNo+1;
yData(1:4) = (W+3)*(sfcNo-1)+1 +whereInPool;
set (mH, 'XData',xData , 'YData',yData);

if ~isempty(spkH)
    set(fData.clearH, 'Enable','on');
    set(spkH, 'UserData',fData)
end



return
