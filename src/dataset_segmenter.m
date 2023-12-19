clc; clear;

% this program segment the original dataset into segmented dataset for training

% prepare folders to crawl
folders = ["fork/", "spoon/"];
[~, len_folders] = size(folders);

% open folder
for i = 1:len_folders
    contents = dir(strcat('../img/original/', folders(i)));
    
    for k = 1:numel(contents)
      % get file name
      filename = contents(k).name;

      % exclude '.' and '..'
      if filename ~= "." && filename ~= ".."
          % log progress
          fprintf('%s [%d / %d] segmenting %s \n', folders(i), k - 2, numel(contents) - 2, filename)

          % read input image
          input_image = imread(strcat('../img/original/', folders(i) ,filename));
          
          % segment image
          output_image = image_segmenter(input_image);
          
          % get just the filename
          [~,name,~] = fileparts(filename);
    
          % prepare file path for output image
          output_filename = sprintf('../img/segmented/%s/%s_segmented.jpg', folders(i), name);
          
          % save output image
          imwrite(output_image,output_filename);
      end                                                                                       
    end
end