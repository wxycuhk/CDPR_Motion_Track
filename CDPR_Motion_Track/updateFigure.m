
function updateFigure(obj, event)
    d = get(obj, 'UserData');        
    % read new data from file
    tmp = readFile(obj);
    % append to array in user data
    d.data = [d.data transpose(tmp)];
    % update the plot 
    set(gcf, 'CurrentAxes', d.axes_handle);
    set(d.line_handle, 'XData', 1:length(d.data), 'YData', d.data);
    % store the timer object user-data
    set(obj, 'UserData', d);
end

