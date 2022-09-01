% Get a list of all txt files in the current folder, or subfolders of it.
fds = fileDatastore('*.txt', 'ReadFcn', @importdata);
fullFileNames = fds.Files;
numFiles = length(fullFileNames);
% Loop over all files reading them in and plotting them.
for k = 1 : numFiles
    fprintf('Now plotting file %s\n', fullFileNames{k});
    filename = fullFileNames{k}; % The fullFileNames also contains directory!
    A = readmatrix(filename); % Automatically skip the headers and directly read the matrix
    Y = A(:,1); % Read the first column
    A(:,1) = []; % Delete the first column
    Z = int32(A); % The rest is the intensity, make sure there is NO OVERFLOW
    Dimension = size(Z); 
    X = int16([1:Dimension(1,2)]); % Make X axis
    contourf(X,Y,Z,50,'LineColor', 'none');
    colorbar
    %caxis([3e4 3.5e4]) % Select the specific scale
    set(gcf,'position',[100,100,400,600]) % Choose the image dimension 400x600
    saveas(gcf,append(erase(filename,".txt"),'.png')) ; % Replace the extension, DO NOT have ".txt" in the directory!
    %% Laplacian Filter
    % sigma = .8;
    % alpha = 0.3;
    % B = locallapfilt(Z, sigma, alpha);
    % contourf(X,Y,B,50,'LineColor', 'none');
    % saveas(gcf,append(erase(filename,".txt"),'.png')) ;
end
