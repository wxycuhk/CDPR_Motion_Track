function stopFigure(obj, event)
    % close function handle
    d = get(obj, 'UserData');
    fclose(d.fid);
end

