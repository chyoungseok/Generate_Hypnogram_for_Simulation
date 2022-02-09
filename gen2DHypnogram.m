function output = gen2DHypnogram(varargin)
    %% Extract options
    if sum(strcmp(varargin, 'plot flag'))==1
        plot_flag = varargin{circshift(strcmp(varargin, 'plot flag'),1)};
    else
        plot_flag = 0;
    end

    epoch_size = 30; % sampling rate=1 --> epoch_size=30은 30초를 의미
    template = zeros(180, 200);
    stage = [1 2 3 4 5];
    stg_size = 30; % stage 하나당 30
    
    %% Generate 2D Hypnogram
    X = {};
    N = 10;
    for n = 1 : N
        x = template;
        i = 1;
        stage_stack = [];
        while 5+epoch_size+epoch_size*(i-1) < size(template, 2)
            now_stage = stage(randi(5));
            stage_stack = [stage_stack, now_stage];
            x(5+stg_size*now_stage, 5+epoch_size*(i-1):5+epoch_size+epoch_size*(i-1)) = 1;
            if i>1
                if stage_stack(i-1) > stage_stack(i)
                    x(5+stg_size*stage_stack(i):5+stg_size*stage_stack(i-1), 5+epoch_size*(i-1))=1;
                else
                    x(5+stg_size*stage_stack(i-1):5+stg_size*stage_stack(i), 5+epoch_size*(i-1))=1;
                end
            end
            i = i+1;
        end
        X{n} = x;
    end
    
    %% plotting
    if plot_flag == 1
        figure;
        for n = 1 : N
            subplot(2,ceil(N/2), n);
            imshow(X{n}, 'InitialMagnification', 10000);
        end
    end

    output = X;
end