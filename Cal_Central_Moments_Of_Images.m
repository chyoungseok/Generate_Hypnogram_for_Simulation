function output = Cal_Central_Moments_Of_Images(X, varargin)
    %% Extract options
    if sum(strcmp(varargin, 'plot flag'))==1
        plot_flag = varargin{circshift(strcmp(varargin, 'plot flag'),1)};
    else
        plot_flag = 0;
    end

    %% Calculate the total_central_moments
    total_central_moments = [];
    for n = 1 : length(X)
        now_X = X{n};
        [height, width] = size(now_X);
         %% Calculate the required parameters
        % define a co-ordinate system for image 
        xgrid = repmat((-floor(height/2):1:ceil(height/2)-1)',1,width);
        ygrid = repmat(-floor(width/2):1:ceil(width/2)-1,height,1);
        
        [x_bar, y_bar] = centerOfMass(now_X,xgrid,ygrid);
        
        % normalize coordinate system by subtracting mean
        xnorm = x_bar - xgrid;
        ynorm = y_bar - ygrid;
        %% Calculate the central moments
        % central moments
        mu_11 = central_moments( now_X ,xnorm,ynorm,1,1);
        mu_20 = central_moments( now_X ,xnorm,ynorm,2,0);
        mu_02 = central_moments( now_X ,xnorm,ynorm,0,2);
        mu_21 = central_moments( now_X ,xnorm,ynorm,2,1);
        mu_12 = central_moments( now_X ,xnorm,ynorm,1,2);
        mu_03 = central_moments( now_X ,xnorm,ynorm,0,3);
        mu_30 = central_moments( now_X ,xnorm,ynorm,3,0);
        now_central_moments = [mu_11, mu_20, mu_02, mu_21, mu_12, mu_03, mu_30];
        total_central_moments = [total_central_moments; now_central_moments];
    end
    output = total_central_moments;

    if plot_flag == 1
        figure;
        for c_i = 1 : size(total_central_moments, 2)
            subplot(2, ceil(size(total_central_moments, 2)/2), c_i)
            plot(total_central_moments(:, c_i)); hold on;
            title(['Central moments ', num2str(c_i)], 'FontSize', 15);
        end
    end
end