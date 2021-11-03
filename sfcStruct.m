% sfcStruct
% script to build a structure showing for each neuron where it takes part
% in the synfire chains.

whereInsfc = struct('sfcNo',{uint16(zeros(N,4))}, ...
    'poolNo',{uint16(zeros(N,4))} ,'whereInPool',{uint16(zeros(N,4))});

for n = 1:N
    [I,J]=find(connections==n);
    numPools=length(I);
    for kk = 1:numPools
        pn = J(kk);
        sfcNo = find(sfc(1,:)<=pn,1,'last');
        whereInsfc.sfcNo(n,kk) = sfcNo;
        whereInsfc.poolNo(n,kk)=pn - sfc(1,sfcNo);
        whereInsfc.whereInPool(n,kk)=I(kk);
    end
end