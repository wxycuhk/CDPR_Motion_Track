function [t] = livePlot(period, filename)

    %   inputs : period : update rate in seconds
    %            filename : name of the file to get data from
    %
    %   outputs: t      : the timer object
    %                     >> stop(t) 
    %                     ends streaming
    %%

    close all;        
    t = timer('StartDelay', 1, 'Period', period, ...
              'ExecutionMode', 'fixedRate');
    %% timer object callback functions
    t.StopFcn  = {@stopFigure};
    t.TimerFcn = {@updateFigure};
    %% initialize timer object user data
    d = get(t, 'UserData');
    d.data = []; % array for the data to plot
    axes('Position', [0 0 1 1], 'Visible', 'off');
    d.axes_handle = axes('Position', [.2 .1 .7 .8]);
    d.line_handle = plot(NaN,NaN);
    d.fid = fopen(filename, 'r');    
    set(t, 'UserData', d);    
    start(t);
end


