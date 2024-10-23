WindSpeed = h2023.RWSP

Time_Initial = datetime('20230101','InputFormat','yyyyMMdd')

Time = Time_Initial + calmonths(h2023.MM) + caldays(h2023.DD) +  hours(h2023.hh) + minutes(h2023.mm)

seconds = zeros(length(h2023.YY),1)

Time_Array = datenum(h2023.YY(:),h2023.MM(:),h2023.DD(:),h2023.hh(:),h2023.mm(:),seconds(:));

Time_Datetime = datetime(Time_Array,'ConvertFrom','datenum');


%%  Clean Data 

Wind_Clean = h2023.RWSP(h2023.RWSP < 90) ;
Time_Clean = Time_Datetime(h2023.RWSP < 90); 

%% Plot Data

figure

plot(Time_Clean,Wind_Clean,'.')

%% Make Histogram

figure
histogram(Wind_Clean,NumBins=30)

%%

figure
histogram(Wind_Clean,'Normalization','pdf',NumBins=50)

%%
hold on


x = linspace(0,max(Wind_Clean),31)
p = raylpdf(x,4.5)
plot(x,p)

p = raylpdf(x,2)
plot(x,p)

p = raylpdf(x,3)
plot(x,p)

p = raylpdf(x,4)
plot(x,p)

p = raylpdf(x,5)
plot(x,p)
