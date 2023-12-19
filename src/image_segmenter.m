function result = image_segmenter(input_image)
    
    % input_image = imread("../img/original/fork/00000003.jpg");

    % resize image
    resized_image = imresize(input_image,[227 227]);

    % convent to grayscale
    gs_image = rgb2gray(resized_image);

    % edge detection with canny
    edge_image = 255 * uint8(edge(gs_image, 'canny'));

    % close image
    se = strel("disk", 20);
    closed_image = imclose(edge_image, se);

    % apply closed_image to resized image
    result = resized_image;
    result(repmat(~closed_image,[1 1 3])) = 0;

    % imshow(input_image);
    % figure; imshow(closed_image);
    % figure; imshow(result);
end