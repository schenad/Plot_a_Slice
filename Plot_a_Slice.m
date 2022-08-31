% Get a list of all txt files in the current folder, or subfolders of it.
fds = fileDatastore('*.txt', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
% Loop over all files reading them in and plotting them.
for k = 1 : numFiles
    fprintf('Now plotting file %s\n', fullFileNames{k});
    filename = fullFileNames{k};
    A = readmatrix(filename);
    Y = A(:,1);
    A(:,1) = [];
    Z = int16(A);
    Dimension = size(Z);
    X = int16([1:Dimension(1,2)]);
    contourf(X,Y,Z,50,'LineColor', 'none');
    set(gcf,'position',[100,100,400,600])
    saveas(gcf,append(erase(filename,".txt"),'.png')) ;
    %% Laplacian Filter
    % sigma = .8;
    % alpha = 0.3;
    % B = locallapfilt(Z, sigma, alpha);
    % contourf(X,Y,B,50,'LineColor', 'none');
    % saveas(gcf,append(erase(filename,".txt"),'.png')) ;
end
