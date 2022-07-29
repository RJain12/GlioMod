% Initialize empty XTrain and YTrain
dim = 64;
tot = 5000; % num of total training samples
tott = 1000; % num of total testing samples
numPatients = 5; % num of training patients
TTrain = zeros(dim,dim,dim,tot);
TTest = zeros(dim,dim,dim,tot/numPatients);

% Create autoencoder to bring image into latentspace

g = 1;
for k = 1:10
    empty = zeros(dim,dim,dim);
     for n = 1 : numPatients
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


g = 1;
for k = 1:10
    empty = zeros(dim,dim,dim);
    for n = numPatients : numPatients + 1
        for m = 1 : size(dayStruct{n,k},3)
            currImage = dayStruct{n,k}(:,:,m);
            copy = empty;
            for l = 1 : length(currImage)
                currRow = currImage(l,:);
                copy(round(currRow(1) * dim),round(currRow(2) * dim), round(dim * currRow(3))) = currRow(4); % * 255
            end
            TTest(:,:,:,g) = copy;
            g = g+1;
        end
    end
end


XTrain = TTrain(:,:,:,1:tot - tot/10);
YTrain = TTrain(:,:,:,tot/10 + 1:tot);

XTest = TTest(:,:,:,1:tott - tott/10);
YTest = TTest(:,:,:,tott/10 + 1:tott);

xds = arrayDatastore(XTrain,IterationDimension=4);
yds = arrayDatastore(YTrain,IterationDimension=4);

cds = combine(xds,yds);
