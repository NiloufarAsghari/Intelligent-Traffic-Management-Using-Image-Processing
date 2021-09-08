% implemented by Niloufar Asghari

clc;
close all;
clear all;

%PreProcessing
v1=VideoReader('Ncars.mp4');
% v1=VideoReader('RainNight.mkv');
Refrence=read(v1,1); % a case which is empty road without vehicle
Nframe55=read(v1,55);
subplot(3,3,1),imshow(Refrence),title('Refrence');
subplot(3,3,2),imshow(Nframe55),title('Frame 55');
Nhsv=rgb2hsv(Nframe55);%convert to hsv to calculate v-hist
Nvimage=Nhsv(:,:,3);
% v-histogram from HSV (Night)
subplot(3,3,3),imhist(Nvimage),title('Night histogram');

% Vehicle Detection in Night Time
night=Nframe55;
night=rgb2gray(night);
ref=rgb2gray(Refrence);
sub=imsubtract(ref,night); 
% figure,imhist(sub); %To help find threshold value
high_pix=max(sub(:)); % Pixle with high intensity for threshold value
sub=im2bw(sub,0.6);
se=strel('disk',1);
sub=imerode(sub,se);

subplot(3,3,4),imshow(sub),title('imopen sub');
sub = bwareaopen(sub, 50); %Remove small pixles
subplot(3,3,5),imshow(sub),title('bwareopen');
sub=imclose(sub,se);
subplot(3,3,6),imshow(sub),title('imclose sub');
sub=imfill(sub,'holes'); %filling the holes
subplot(3,3,7),imshow(sub),title('imfill');

%For removing Pixles
final = bwareafilt(sub, [1, 200]);% Remove objects if they are not between 1 to 200 pixles
subplot(3,3,8),imshow(final),title('Reflex Removed');



[x,LightNumber]=bwlabel(final); %Counter light number
carnumbers=ceil(LightNumber/2);
