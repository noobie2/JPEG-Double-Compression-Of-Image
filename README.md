# JPEG-Double-Compression-Of-Image

In this program, I have used MATLAB to read an input image(jpg format), appply compression to it,again apply the compression a second time and then finally display and compare the results.

This program is able to achieve very high levels of compresions, reducing the size of a jpg image drastically. The code takes an image called 'tulip.jpg' as the input, which can be changed for any image.

The function works by first getting the original image information such as filesize and dimensions. Then the input image is cropped to make it a square along it's minimum dimension value. After this, the main compression function is called two times. The function seperates the image into RGB components and calculates the DCT coefficients for each component and then truncates those coefficients to achieve compression. This is the most important part as, this step allows for high compression without any significant loss in quality. it then calculates the image properties such as compression ratio, noise etc. The second compression can be omitted as it's done only so that the PSNR of the image is reduced. I used a low threshold value in the range of 0-20, to achieve compression.
You could experiment with higher values but they caused too much distortion for me.

Along with the code, there is a powerpoint presentation attached which i presented in my college.

Thank You.
