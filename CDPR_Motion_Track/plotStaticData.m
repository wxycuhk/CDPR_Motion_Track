function plotStaticData()
    % Create the main figure
    fig = figure('Name', 'Static Data Plotting', 'NumberTitle', 'off', 'Position', [100, 100, 800, 600]);

    % Create axes for plotting
    ax = axes('Parent', fig, 'Position', [0.1, 0.2, 0.8, 0.7]);

    % Read data from the finished text file (assuming the format is the same)
    data = dlmread('copied_data.txt'); % Update with your file name

    % Extract the data for each column
    column1 = data(:, 1);
    column2 = data(:, 2);
    column3 = data(:, 3);

    % Plot the data for each column
    plot(ax, column1, 'LineWidth', 2, 'DisplayName', 'Column 1');
    hold(ax, 'on');
    plot(ax, column2, 'LineWidth', 2, 'DisplayName', 'Column 2');
    plot(ax, column3, 'LineWidth', 2, 'DisplayName', 'Column 3');

    xlabel(ax, 'Time (Line Count)');
    ylabel(ax, 'Data');
    legend(ax, 'Location', 'Best');
    title(ax, 'Static Data Plot');
end
