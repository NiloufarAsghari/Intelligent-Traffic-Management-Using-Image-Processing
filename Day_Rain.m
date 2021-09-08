% implemented by Niloufar Asghari

clc;
close all;
clear all;

%PreProcessing

v1=VideoReader('EDay.mp4');
Refrence=read(v1,40); % a case which is empty road or at least cars without vehicle

Dframe300=read(v1,130);
subplot(3,3,1),imshow(Refrence),title('Refrence');
subplot(3,3,2),imshow(Dframe300),title('Frame 40');
Dhsv=rgb2hsv(Dframe300);%convert to hsv to calculate v-hist
Dvimage=Dhsv(:,:,3);
% v-histogram from HSV (Day)
subplot(3,3,3),imhist(Dvimage),title('Day histogram');



% Vehicle Detection in Day Time
day=Dframe300;
day=rgb2gray(day);
ref=rgb2gray(Refrence);
sub1=imsubtract(day,ref); %foreground subtracted from background
subplot(3,3,4),imshow(sub1),title('foreground sub');
sub2=imsubtract(ref,day); %background subtracted from foreground
subplot(3,3,5),imshow(sub2),title('background sub');
% BW with threshold value 
img1=im2bw(sub1,0.1);
subplot(3,3,6),imshow(img1),title('BW sub1');
img2=im2bw(sub2,0.1);
subplot(3,3,7),imshow(img2),title('BW sub2');

%Merge 2 subtraction Result
day = img1+img2;
subplot(3,3,8),imshow(day),title('Merge');
