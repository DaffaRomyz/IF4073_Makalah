% load model
load('cnn_model', 'netTransfer');

% load image
input_image = imread('../img/test/4.jpg');
imshow(input_image);

% convert to grayscale
gs_image = rgb2gray(input_image);
% figure; imshow(gs_image);

% convert to binary
bw_image = imbinarize(gs_image);
% figure; imshow(bw_image);

% convert to negative
[M, N] = size(bw_image);
for i = 1:M
    for j = 1:N
        % reduce the pixel intensity value from maximum gray value
        neg_image(i, j) = 1 - bw_image(i, j);
    end
end

% figure; imshow(neg_image);

% fill holes
closed_image = imfill(neg_image, "holes");
% figure; imshow(closed_image);

% area filter
area_image = bwareaopen(closed_image, 10000);
% figure; imshow(area_image);

% set bounding box
boxes = regionprops(area_image, "BoundingBox");

figure;
imshow(area_image);
hold on;
for i=1:length(boxes)
    box = boxes(i).BoundingBox;
    rectangle('Position', box, 'EdgeColor', 'r', 'LineWidth',3);
end

% count spoon and fork
spoon = 0;
fork = 0;

for j=1:length(boxes)
    box = boxes(j).BoundingBox;
    
    % crop image
    cropped_image = imcrop(input_image, box);

    % resize
    resized_image = imresize(cropped_image, [227 227]);

    % classify
    label = classify(netTransfer, resized_image);
    
    % figure;imshow(cropped_image); title(label);

    % increment amount
    if (label == "spoon")
        spoon = spoon + 1;
    else
        fork = fork + 1;
    end
end

fprintf('Spoon = %d \n', spoon);
fprintf('Fork = %d \n', fork);