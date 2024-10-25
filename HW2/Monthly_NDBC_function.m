function [DATA_Struct] = Monthly_NDBC_function(Data,DATA_Struct,TimeSeries_Variable_2022,TimeSeries_Variable_2023,YearMonth,Threshold)


for i = 1:24
    if i <= 12
        DATA_Struct{i,1} = Data.h2022.Datetime( Data.h2022.MM == i & TimeSeries_Variable_2022 < Threshold );
        DATA_Struct{i,2} = TimeSeries_Variable_2022 ( Data.h2022.MM == i & TimeSeries_Variable_2022 < Threshold ) ;
        DATA_Struct{i,3} = mean(DATA_Struct{i,2});
        DATA_Struct{i,4} = std(DATA_Struct{i,2});
        DATA_Struct{i,5} = length(DATA_Struct{i,2} );
        DATA_Struct{i,6} = DATA_Struct{i,4} / (sqrt( DATA_Struct{i,5} / (7*24*6) ));

        % plot( Data.Mean.WSPD{i,1},Data.Mean.WSPD{i,2},'.')
    else
        DATA_Struct{i,1} = Data.h2023.Datetime( Data.h2023.MM == (i-12) & TimeSeries_Variable_2023 < Threshold );
        DATA_Struct{i,2} = TimeSeries_Variable_2023 ( Data.h2023.MM == (i-12) & TimeSeries_Variable_2023 < Threshold ) ;
        DATA_Struct{i,3} = mean(DATA_Struct{i,2});
        DATA_Struct{i,4} = std(DATA_Struct{i,2});
        DATA_Struct{i,5} = length(DATA_Struct{i,2} );
        DATA_Struct{i,6} = DATA_Struct{i,4} / (sqrt( DATA_Struct{i,5} / (7*24*6) ));

        % plot( Data.Mean.WSPD{i,1},Data.Mean.WSPD{i,2},'.')
    end

end

figure
errorbar(YearMonth,[DATA_Struct{:,3}],[DATA_Struct{:,6}])

end