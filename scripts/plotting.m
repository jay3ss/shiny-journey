function [yhat_train,yhat_test] = plotting(w_train,X_train,X_test,y_train,y_test,nbins)
    yhat_train=X_train*w_train;  % estimate for training
    yhat_test=X_test*w_train;    % weights for training are used for testing
    % plots----------------------------------------------------------------
    figure
    plot(yhat_train,y_train,'.');
    hold on
    plot(yhat_test,y_test,'.r');
    grid on
    xlabel('measured data')
    ylabel('estimated data');
    legend('train','test');
    title('measured vs estimated data (training and test) feature F0');
    grid on
    % histograms-----------------------------------------------------------
    error_train=y_train-yhat_train;
    error_test=y_test-yhat_test;
    figure
    hist(error_train,nbins);
    title('histogram for training error for feature F0 (MMSE)');
    grid on
    figure
    hist(error_test,nbins);
    title('histogram for testing error for feature F0 (MMSE)');
    grid on

end

