%XTrain = cell(5400,1);
%YTrain = cell(5400,1);

% Create autoencoder to bring image into latentspace

dayStruct = {};
for k = 1:6
    myFolder = "/Users/rishabjain/Desktop/rsi/procDataCSV/P"+k+"_dat";
    theFiles50 = dir(fullfile(myFolder, '**/50.csv'));
    theFiles100 = dir(fullfile(myFolder, '**/100.csv'));
    theFiles150 = dir(fullfile(myFolder, '**/150.csv'));
    theFiles200 = dir(fullfile(myFolder, '**/200.csv'));
    theFiles250 = dir(fullfile(myFolder, '**/250.csv'));
    theFiles300 = dir(fullfile(myFolder, '**/300.csv'));
    theFiles350 = dir(fullfile(myFolder, '**/350.csv'));
    theFiles400 = dir(fullfile(myFolder, '**/300.csv'));
    theFiles450 = dir(fullfile(myFolder, '**/450.csv'));
    theFiles500 = dir(fullfile(myFolder, '**/500.csv'));

    % Initialize the arrays.
    n = 1;
    dayStruct{k,1} = readmatrix(fullfile(theFiles50(n).folder, theFiles50(n).name));
    dayStruct{k,2} = readmatrix(fullfile(theFiles100(n).folder, theFiles100(n).name));
    dayStruct{k,3} = readmatrix(fullfile(theFiles150(n).folder, theFiles150(n).name));
    dayStruct{k,4} = readmatrix(fullfile(theFiles200(n).folder, theFiles200(n).name));
    dayStruct{k,5} = readmatrix(fullfile(theFiles250(n).folder, theFiles250(n).name));
    dayStruct{k,6} = readmatrix(fullfile(theFiles300(n).folder, theFiles300(n).name));
    dayStruct{k,7} = readmatrix(fullfile(theFiles350(n).folder, theFiles350(n).name));
    dayStruct{k,8} = readmatrix(fullfile(theFiles400(n).folder, theFiles400(n).name));
    dayStruct{k,9} = readmatrix(fullfile(theFiles450(n).folder, theFiles450(n).name));
    dayStruct{k,10} = readmatrix(fullfile(theFiles500(n).folder, theFiles500(n).name));

    for n = 2 : length(theFiles50)
        dayStruct{k,1} = cat(3,dayStruct{k,1},readmatrix(fullfile(theFiles50(n).folder, theFiles50(n).name)));
        dayStruct{k,2} = cat(3,dayStruct{k,2},readmatrix(fullfile(theFiles100(n).folder, theFiles100(n).name)));
        dayStruct{k,3} = cat(3,dayStruct{k,3},readmatrix(fullfile(theFiles150(n).folder, theFiles150(n).name)));
        dayStruct{k,4} = cat(3,dayStruct{k,4},readmatrix(fullfile(theFiles200(n).folder, theFiles200(n).name)));
        dayStruct{k,5} = cat(3,dayStruct{k,5},readmatrix(fullfile(theFiles250(n).folder, theFiles250(n).name)));
        dayStruct{k,6} = cat(3,dayStruct{k,6},readmatrix(fullfile(theFiles300(n).folder, theFiles300(n).name)));
        dayStruct{k,7} = cat(3,dayStruct{k,7},readmatrix(fullfile(theFiles350(n).folder, theFiles350(n).name)));
        dayStruct{k,8} = cat(3,dayStruct{k,8},readmatrix(fullfile(theFiles400(n).folder, theFiles400(n).name)));
        dayStruct{k,9} = cat(3,dayStruct{k,9},readmatrix(fullfile(theFiles450(n).folder, theFiles450(n).name)));
        dayStruct{k,10} = cat(3,dayStruct{k,10},readmatrix(fullfile(theFiles500(n).folder, theFiles500(n).name)));
    end
end