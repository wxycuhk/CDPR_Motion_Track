function [tmp] = readFile(obj)
    % read binary data. file-ID is in the timer user-data
    d = get(obj, 'UserData');
    tmp = fread(d.fid);
    fprintf('Current file location : %d \n', ftell(d.fid));
    % fprintf('End of file indicator : %d \n', feof(d.fid));
    % reset the end-of-file indicator
    fseek(d.fid, -1, 0);
    fseek(d.fid, 1, 0);
    % fprintf('End of file indicator : %d \n', feof(d.fid));
    set(obj, 'UserData', d); 
end