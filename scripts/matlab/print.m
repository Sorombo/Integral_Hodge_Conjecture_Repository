function [] = print(filename, M)

    %Number of columns is determined
    [~, nrocol]= size(M);
    
    %We specify the format we want to write in
    atomo   = '\t\t%d';
    formato = '%d';
    for(i=2:nrocol)
        formato =  strcat(formato, atomo);
    end
    formato = strcat(formato, '\n');
    
    %Print file
    fileID = fopen(filename, 'w');
    fprintf(fileID, formato, M');
    fclose(fileID);
end

