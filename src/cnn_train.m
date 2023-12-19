% load training dataset and validation_dataset
load('train_set', 'train_set');
load('valid_set', 'valid_set');
disp('data loaded');

% load pre-trained alex net
net = alexnet;
disp('net loaded');

% replace final three layer
layersTransfer = net.Layers(1:end-3);
numClasses = numel(categories(train_set.Labels));
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
disp('layer specified');

% prepare training options
options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',6, ...
    'InitialLearnRate',1e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData', valid_set, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');
disp('training option specified');

% train network
netTransfer = trainNetwork(train_set,layers,options);
save('cnn_model', 'netTransfer');
disp('model trained');