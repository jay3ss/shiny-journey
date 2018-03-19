function []= mlplot(structEST)

plotType = structEST.type;

switch plotType
    case {'MMSE', 'PCR'} 
        % Extract data from struct
        yhat_train = structEST.yhat.train;
        yhat_test= structEST.yhat.test;
        
        y_train = structEST.y.train;
        y_test = structEST.y.test;
        
        w_ordered = structEST.w_ordered;
        
        error_train = structEST.error.train;
        error_test = structEST.error.test;
        
        F0 = structEST.F0;
        nbins = structEST.nbins;
        
        % Plot
        figure
        plot(yhat_train,y_train,'.');
        hold on
        plot(yhat_test,y_test,'.r');
        grid on
        
        xlabel('Measured Data')
        ylabel('Estimated Data');
        legend('Training','Testing');
        title(['Measured vs ', plotType,' Estimated Data, Feature F0: ', num2str(F0)]);
        grid on
        
        figure
        stem(w_ordered);
        grid on
        xlabel('Data Set Index')
        ylabel('Feature Weight');
        title([ plotType,' Estimation Weights, Feature F0: ', num2str(F0)]);
        
        figure
        
        hist(error_train,nbins);
        title([plotType, ' Histogram for Training Error for Feature F0: ', num2str(F0)]);
        grid on
        
        figure
        hist(error_test,nbins);
        title([plotType, ' Histogram for Testing Error for Feature F0: ', num2str(F0)]);
        grid on
        
        
        if strcmp(plotType,'PCR')
            figure
            mesh(structEST.corr.mat)
            grid on
            title('correlation matrix');
        end
        
    case 'p-log'      
        % Extract data from struct
        a_train_pcr = structEST.accPCR.train;
        a_test_pcr = structEST.accPCR.test;
        a_train_mmse = structEST.accMMSE.train;
        a_test_mmse = structEST.accMMSE.test;
        
        % Plot
        figure
        
        grid on
        hold on
        
        plot(log10(a_train_pcr(:,1)),'r-');
        plot(log10(a_train_pcr(:,2)),'r--');
        plot(log10(a_train_mmse(:,1)),'m-.');
        plot(log10(a_train_mmse(:,2)),'m:');
        
        plot(log10(a_test_pcr(:,1)),'b-');
        plot(log10(a_test_pcr(:,2)),'b--');
        plot(log10(a_test_mmse(:,1)),'g-.');
        plot(log10(a_test_mmse(:,2)),'g:');
        
        title('Accuracy of the MMSE and PCR estimate')
        legend('training-pcr_5','training-pcr_7','training-mmse_5','training-mmse_7',...
            'test-pcr_5','test-pcr_7','test-mmse_5','test-mmse_7');
        
        xlabel('Number of Features');
        ylabel('Log10(Accuracy)')


end

end