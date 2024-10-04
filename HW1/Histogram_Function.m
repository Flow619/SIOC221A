function [] = Histogram_Function(Variable,XLABEL_String, nBins,FaceAlpha,FigureFlag)

Bins = linspace(min(Variable),max(Variable), (nBins + 1));

Temp_Binned = discretize(Variable,Bins);

counts = [];

for i = 1:nBins

    counts = [counts, sum(Temp_Binned == i) ];

end

probability = counts./sum(counts);

if strcmp(FigureFlag,"NEWFIG") == 1 
figure
histogram('BinEdges',Bins,'BinCounts',probability,'FaceColor',[128/256,0,0],'EdgeColor',[255/256,223/256,0],'FaceAlpha',FaceAlpha)

else
histogram('BinEdges',Bins,'BinCounts',probability,'EdgeColor',[0 0 0],'FaceAlpha',FaceAlpha,DisplayStyle='stairs',LineWidth=1)

end

ylabel('Probability')
xlabel(XLABEL_String)

set(gca,'FontSize',20)

title(['Empirical Probability Distribution Function: ', num2str(nBins), ' bins'])

end