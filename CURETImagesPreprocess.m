clc,clear,close all;
%When process enhanced, use these two lines. Change the number behind
%\sample from 1 to 3
%Dataset = imageDatastore("D:\216\ECE515\Texture_Classification\MetalClassification\sample01");
%WriteDir = "D:\216\ECE515\Texture_Classification\MetalClassification\Enhanced_Cutted";

%When process original images, use these two lines. Change the number behind
%\sample from 1 to 3
Dataset = imageDatastore("D:\216\ECE515\Texture_Classification\MetalClassification\Original_Uncut\sample03");
WriteDir = "D:\216\ECE515\Texture_Classification\MetalClassification\Original_Cutted";

Imgset = readall(Dataset);
Setlen = size(Imgset,1);
Filenames = Dataset.Files;
for i = 1:Setlen
    Filename = string(Filenames(i));
    SingleName = split(Filename,"\");
    SingleName = SingleName(end);
    Filenamew = append(WriteDir,"\",SingleName);
    im=cell2mat(Imgset(i));
    im = rgb2gray(im);
    Picsize = size(im);
    Xstart = floor((Picsize(1)-256)/2);
    Ystart = floor((Picsize(2)-256)/2);
    Subimage = im(Xstart:1:(Xstart+255),Ystart:1:(Ystart+255));
    imwrite(Subimage,Filenamew);
end