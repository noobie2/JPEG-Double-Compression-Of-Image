
%%% Cleaning the workspace and variables %%%%%%%%
warning off;
clear comp;
close all;
clc;

%% Reading an input image 

% Read Color image
image=double((imread('tulip.jpeg')));
data_orig=imfinfo('tulip.jpeg');
original_file_size=data_orig.FileSize;


%% Computing the size of an image
[m1,n1,dim]=size(image);
z=min(m1,n1);
image_square=(imresize(image,[z z]));

%% Function call
[temp,c1,CR1] = comp(image_square);
[fin,c2,CR2] = comp(temp);



%% Plotting the results
    imshow(uint8(image_square)),title('Original image');
    figure;
    imshow(uint8(fin)),title('Compressed image');
    figure;

%% Putting the images in the directory
    imwrite(uint8(image_square),'original_image_colored.jpeg');
    imwrite(uint8(fin),'Compressed_image_coloured.jpeg');
    
    
    
    
    
function [image_compressed,compressed_file_size,Compression_ratio] = comp(image_square)
%% Computing the size of an image
[m1,n1,dim]=size(image);
z=min(m1,n1);

%% Selection of threshold value for DCT coefficients
% For coloured image in this tutorial we used thresh value of 5,50 and 500 


prompt = 'Enter the compression percentage?:';
thresh = input(prompt);


%% Compute the size of a square image

[m2,n2]=size(image_square);

%% Calculation the DCT basis matrix

for i=1:m2
    for j=1:m2
        if(i==1)
          z(i,j)=sqrt(1/n2)*cos(((2*j-1)*(i-1)*pi)/(2*n2));
        else
          z(i,j)=sqrt(2/n2)*cos(((2*j-1)*(i-1)*pi)/(2*n2)); 
        end
    end
end

%% Calculate the DCT coefficents for each RGB components of an image

DCT_red=z*image_square(:,:,1)*z';
DCT_green=z*image_square(:,:,2)*z';
DCT_blue=z*image_square(:,:,3)*z';


%% Truncating the DCT coefficients to achieve compression for each channel

DCT_red(abs(DCT_red)<thresh)=0;
DCT_green(abs(DCT_green)<thresh)=0;
DCT_blue(abs(DCT_blue)<thresh)=0;

DCT(:,:,1)=DCT_red;
DCT(:,:,2)=DCT_green;
DCT(:,:,3)=DCT_blue;

%% Reconstruction of the compresed image from each channel

image_compressed(:,:,1)=z'*DCT_red*z;
image_compressed(:,:,2)=z'*DCT_green*z;
image_compressed(:,:,3)=z'*DCT_blue*z;

imwrite(uint8(image_compressed),'Compressed_image_coloured.jpeg');

%% Compression ratio

data_orig=imfinfo('tulip.jpeg');  

original_file_size=data_orig.FileSize;
data_comp=imfinfo('Compressed_image_coloured.jpeg');
compressed_file_size=data_comp.FileSize;
Compression_ratio=floor(original_file_size/compressed_file_size);
end