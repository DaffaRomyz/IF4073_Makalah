% load dataset
dataset = imageDatastore('../img/segmented/', 'IncludeSubfolders',true, 'LabelSource','foldernames');
disp('data loaded');

% split dataset into training dataset and validation dataset
[train_set, valid_set] = splitEachLabel(dataset, 70,'randomized');
disp('data split');

% save split data
save('train_set', 'train_set');
save('valid_set', 'valid_set');