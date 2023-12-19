% load model
load('cnn_model', 'netTransfer');

% load validation dataset
load('valid_set', 'valid_set');

% predict validation dataset
[YPred,scores] = classify(netTransfer, valid_set);

% calculate accuracy
YValidation = valid_set.Labels;
accuracy = mean(YPred == YValidation);
disp(accuracy);