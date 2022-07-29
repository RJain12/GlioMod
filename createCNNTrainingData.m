% Initialize empty XTrain and YTrain
dim = 64;
tot = 5000;
TTrain = zeros(dim,dim,dim,tot);
%YTrain = cell(5400,1);

% Create autoencoder to bring image into latentspace

g = 1;
for k = 1:10
    empty = zeros(dim,dim,dim);
    for n = 1 : 5
        for m = 1 : size(dayStruct{n,k},3)
            currImage = dayStruct{n,k}(:,:,m);
            copy = empty;
            for l = 1 : length(currImage)
                currRow = currImage(l,:);
                copy(round(currRow(1) * dim),round(currRow(2) * dim), round(dim * currRow(3))) = currRow(4); % * 255
            end
            TTrain(:,:,:,g) = copy;
            g = g+1;
        end
    end
end

XTrain = TTrain(:,:,:,1:tot - tot/10);
YTrain = TTrain(:,:,:,tot/10 + 1:tot);

xds = arrayDatastore(XTrain,IterationDimension=4);
yds = arrayDatastore(YTrain,IterationDimension=4);

cds = combine(xds,yds);