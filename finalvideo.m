tic;
obj = VideoReader('ground.mov');
nframes = read(obj, 100);

nframes = get(obj, 'NumberOfFrames');

I = read(obj, 1);
%taggedCars = zeros([size(I,1) size(I,2) 3 nframes], class(I));
taggedCars = zeros(size(I,1), size(I,2),'like',I);
for k = 800 : 810
    img= read(obj, k);
    ycbcr=rgb2gray(img);
    ycbcry = ycbcr;
    ycbcry(:,:,2) = 0;
    ycbcry(:,:,3) = 0;
    rgb1 = ycbcr2rgb(ycbcry);
    img1 = rgb2gray(rgb1);
%     figure,imshow(img1);
     red = imsubtract(img1,ycbcr(:,:,1));%1 for red,2 for green ,3 for blue
%      figure,imshow(red);
     textureImage = stdfilt(red,true(9));
%      figure; imshow(textureImage,[]);
%     fontSize=12;
%     title('Texture Image','FontSize',fontSize);
%     colorbar;
%     axis on;
    thresholded =textureImage>15 ; %% Threshold to isolate lungs
    thresholded = bwareaopen(thresholded,45);  % remove too small pixels
    I2=thresholded.*textureImage;
    I3=edge(I2,'canny',graythresh(I2));  % ostu method
    I3 = imfill(I3,'hole');
    CC = bwconncomp(I3);labeled = labelmatrix(CC);
    BW21 = bwareaopen(labeled,400);
    L = bwlabel(BW21); 
BW22 = im2bw(L,0.9);                   %# binarize image
BW22 = imdilate(BW22,strel('square',4)); %# dilation
BW22 = imfill(BW22,'holes');             %# fill inside silhouette
BW22 = imerode(BW22,strel('square',3));  %# erode
BW22 = bwperim(BW22,4);                  %# get perimeter
% imshow(BW22);
CC = bwconncomp(BW22);labeled = labelmatrix(CC);
BW21 = bwareaopen(labeled,250);
L = bwlabel(BW21); 
% figure,imshow(L);
s = regionprops(L,'Area','Centroid','BoundingBox','FilledArea','Image','Perimeter');
allBlobAreas = [s.Area];
boxes=cat(1,s.BoundingBox);
  figure,imshow(img);
  hold on;
imshow(img);
p1=[350,70];
p2=[350,1100];
plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','g','LineWidth',2)
hold on;
p11=[700,1100];
p21=[200,1100];
plot([p11(2),p21(2)],[p11(1),p21(1)],'Color','b','LineWidth',2)
    for k = 1 : length(s)
          thisBB = s(k).BoundingBox;
          rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],...
         'EdgeColor','r','LineWidth',2 );
%      img1= imcrop(img,thisBB);
%     imwrite(img1,sprintf('cell%d.jpg',k));
    end 
 num1 = xlsread('E:\MATLAB\R2014a\bin\hogsvm\hogg.xlsx');
save aarthi1.mat num1
load aarthi1.mat
num2=xlsread('E:\MATLAB\R2014a\bin\hogsvm\testt.xlsx');
save aarthi2.mat num2
load aarthi2.mat
c=[];
Sample=[];
for i=1:9
c(:,i)=num1(:,i);
Sample(:,i)=num2(:,i);
end
y=num1(:,10);

[cc]=multisvm(c,y,Sample);

for k = 1:2
    c = s(k).Centroid;
    text(c(1), c(2), sprintf('%d',cc(k,1)), ...
         'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle');
    
    str=sprintf('human',c(1),c(2));
    annotation('textbox',[0.6,0.6,0.1,0.1],'String',str);
    hold on;
    
     str1=sprintf('car',c(2),c(1));
    annotation('textbox',[0.4,0.7,0.1,0.1],'String',str1);
   
%      X(k)=thisBB(1);
%  Y(k)=thisBB(2);
%  dist=((X(k)-X(k-1))^2+(Y(k)-Y(k-1))^2)^(1/2);
%  Z(k)=dist;
 end
 
x1 = thisBB(1); %some point
a1 = p1; %segment points a,b
b1 = p2;

d_ab1 = norm(a1-b1);
d_ax1 = norm(a1-x1);
d_bx1 = norm(b1-x1);

if dot(a1-b1,x1-b1)*dot(b1-a1,x1-a1)>=0
    A1 = [a1,1;b1,1;x1,1];
    dist1 = abs(det(A1))/d_ab1;        
else
    dist1 = min(d_ax1, d_bx1);
end

x = thisBB(2); %some point
a = p11; %segment points a,b
b = p21;

d_ab = norm(a-b);
d_ax = norm(a-x);
d_bx = norm(b-x);

if dot(a-b,x-b)*dot(b-a,x-a)>=0
    A = [a,1;b,1;x,1];
    dist2 = abs(det(A))/d_ab;        
else
    dist2 = min(d_ax, d_bx);
end

m1=median(dist1);
m2=median(dist2);
s1=m1*(120/8);
s2=m2*(120/8);
end

Message1='do not cross';
Message2='cross';
% s1=(dist1*0.2*5)/(18*0.344);
% s2=(dist2*0.2*5)/(18*0.344);
if (dist1 >= 1) && (dist2 >= 900)
    %disp('do not cross')
    msgbox(Message1)
else
    %disp('cross')
    msgbox(Message2)
end


frameRate = get(obj,'FrameRate');
% implay(taggedCars,frameRate);
implay(taggedCars);
toc;
