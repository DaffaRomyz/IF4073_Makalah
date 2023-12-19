function result = cnn_predict(input_image)

    % input_image = imread("../img/original/fork/00000003.jpg");

    % resize image
    resized_image = imresize(input_image,[227 227]);
    
    % load model
    load('cnn_model', 'netTransfer');

    % predict image
    label = classify(netTransfer, resized_image);

    % return result
    result = string(label);

    % imshow(input_image); title(label);
end