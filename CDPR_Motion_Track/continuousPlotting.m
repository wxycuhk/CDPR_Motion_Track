function continuousPlotting()
    % Create the main figure
    fig = figure('Name', 'Continuous Plotting', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);

    % Create axes for plotting
    ax = axes('Parent', fig, 'Position', [0.1, 0.2, 0.8, 0.7]);

    % Create buttons
    startButton = uicontrol('Style', 'pushbutton', 'String', 'Start', 'Position', [20, 20, 80, 30], 'Callback', @startButtonCallback);
    endButton = uicontrol('Style', 'pushbutton', 'String', 'End', 'Position', [120, 20, 80, 30], 'Callback', @endButtonCallback);

    % Initialize plotting data
    x = [];
    y = [];

    % Initialize plotting lines
    lines = [];

    % Flag to control data streaming
    streaming = false;

    function startButtonCallback(~, ~)
        nonBlockingFileReader(); % Start reading data from the file
        streaming = true;
    end

    function endButtonCallback(~, ~)
        streaming = false;
    end

    function nonBlockingFileReader()
        try
            % Specify the file name to read
            fileName = 'copied_data.txt'; % Update with your file name

            % Open the file for reading
            fileID = fopen(fileName, 'r');

            % Initialize line counter 
            lineCounter = 0;

            % Read and plot data continuously 
            while ishandle(fig) && streaming
                % Read the next line from the file
                line = fgetl(fileID);

                % Check if the end of the file is reached
                if line == -1
                    pause(1); % Wait for a while and check again
                else
                    lineCounter = lineCounter + 1;
                    data = str2double(strsplit(line));

                    % Update x values (assuming time values)
                    x = [x, lineCounter / 100];

                    % Update y values (assuming four columns of data)
                    y = [y; data];

                    % Plot the data
                    if isempty(lines)
                        for i = 1:size(y, 2)
                            lines(i) = plot(ax, x, y(:, i), 'LineWidth', 2);
                            hold(ax, 'on');
                        end
                        xlabel(ax, 'Time');
                        ylabel(ax, 'Data');
                        legend(ax, arrayfun(@(i) sprintf('Column %d', i), 1:size(y, 2), 'UniformOutput', false));
                    else
                        for i = 1:size(y, 2)
                            set(lines(i), 'XData', x, 'YData', y(:, i));
                        end
                    end

                    % Adjust the x-axis limits for better visualization
                    xlim(ax, [max(1, lineCounter - 100), lineCounter + 10]);
                    drawnow; % Update the plot

                    % Add a slight delay to control the update rate
                    pause(0.01);
                end
            end

            % Close the file when streaming is finished
            fclose(fileID);

        catch
            % Handle any errors or exceptions that may occur during streaming
            streaming = false;
            fclose(fileID); % Close the file in case of an error
        end
    end
end
