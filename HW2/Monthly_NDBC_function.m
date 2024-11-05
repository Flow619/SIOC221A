function [DATA_Struct,fig] = Monthly_NDBC_function(Data,DATA_Struct,TimeSeries_Variable_2022,TimeSeries_Variable_2023,YearMonth,Threshold,fig,Subplot_Number)


for i = 1:24
    if i <= 12
        DATA_Struct{i,1} = Data.h2022.Datetime( Data.h2022.MM == i & TimeSeries_Variable_2022 < Threshold );    % Pull datetime from ith month (only good date; below threshold)
        DATA_Struct{i,2} = TimeSeries_Variable_2022 ( Data.h2022.MM == i & TimeSeries_Variable_2022 < Threshold ) ;    % Pull data from ith month (only good date; below threshold)
        DATA_Struct{i,3} = mean(DATA_Struct{i,2});  % take mean
        DATA_Struct{i,4} = std(DATA_Struct{i,2});   % take std dev
        DATA_Struct{i,5} = length(DATA_Struct{i,2} );   % num of observation in that month
        DATA_Struct{i,6} = DATA_Struct{i,4} / (sqrt( DATA_Struct{i,5} / (7*24*6) ));   % Calculate standard error

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

figure(fig)
subplot(4,1,Subplot_Number)
errorbar(YearMonth,[DATA_Struct{:,3}],[DATA_Struct{:,6}],'r','linewidth',2.5,'CapSize',10)

end