imageLayer = image3dInputLayer([dim,dim,dim,1],Normalization="none");

layers = [
    image3dInputLayer([64 64 64 1],"Name","input","Normalization","none")
    convolution3dLayer([7 7 7],4,"Name","conv3d_1","Padding","same")
    batchNormalizationLayer("Name","batchnorm_1")
    swishLayer("Name","swish_1")
    maxPooling3dLayer([2 2 2],"Name","maxpool3d_1","Padding","same","Stride",[2 2 2])
    convolution3dLayer([5 5 5],8,"Name","conv3d_2","Padding","same")
    batchNormalizationLayer("Name","batchnorm_2")
    swishLayer("Name","swish_2")
    maxPooling3dLayer([2 2 2],"Name","maxpool3d_2","Padding","same","Stride",[2 2 2])
    convolution3dLayer([3 3 3],16,"Name","conv3d_3","Padding","same")
    batchNormalizationLayer("Name","batchnorm_3")
    swishLayer("Name","swish_3")
    maxPooling3dLayer([2 2 2],"Name","maxpool3d_3","Padding","same","Stride",[2 2 2])
    convolution3dLayer([3 3 3],32,"Name","conv3d_4","Padding","same")
    batchNormalizationLayer("Name","batchnorm_4")
    swishLayer("Name","swish_4")
    maxPooling3dLayer([2 2 2],"Name","maxpool3d_4","Padding","same","Stride",[2 2 2])
    transposedConv3dLayer([2 2 2],32,"Name","transposed-conv3d_1","Stride",[2 2 2])
    batchNormalizationLayer("Name","batchnorm_5")
    swishLayer("Name","swish_5")
    transposedConv3dLayer([2 2 2],16,"Name","transposed-conv3d_2","Stride",[2 2 2])
    batchNormalizationLayer("Name","batchnorm_6")
    swishLayer("Name","swish_6")
    transposedConv3dLayer([2 2 2],8,"Name","transposed-conv3d_3","Stride",[2 2 2])
    batchNormalizationLayer("Name","batchnorm_7")
    swishLayer("Name","swish_7")
    transposedConv3dLayer([2 2 2],4,"Name","transposed-conv3d_4","Stride",[2 2 2])
    batchNormalizationLayer("Name","batchnorm_8")
    swishLayer("Name","swish_8")
    convolution3dLayer([1 1 1],1,"Name","conv3d_5","Padding","same")
    batchNormalizationLayer("Name","batchnorm_9")
    clippedReluLayer(1,"Name","clippedrelu")
    regressionLayer("Name","regressionoutput")];

%plot(layerGraph(layers));

options = trainingOptions("adam", ...
    MaxEpochs=30, ...
    MiniBatchSize=1, ...
    Plots="training-progress", ...
    ResetInputNormalization=false, ...
    ExecutionEnvironment="auto", ...
    InitialLearnRate=0.006, ...
     LearnRateSchedule='piecewise',...
    LearnRateDropPeriod=1,...
    LearnRateDropFactor=0.1,...
    CheckPointFrequency=1,...
    CheckpointFrequencyUnit="epoch",...
    CheckpointPath="checkpoints",...
    Verbose=true);

net = trainNetwork(cds,layers,options);
save("test.mat","net");