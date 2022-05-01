clc,clear,close all;
try
    load("CNNDEsign.mat");
catch
    UnEnhanceUncutName = ["D:\216\ECE515\Texture_Classification\MetalClassification\Original_Uncut\sample01" ... 
        ,"D:\216\ECE515\Texture_Classification\MetalClassification\Original_Uncut\sample02", ... 
        "D:\216\ECE515\Texture_Classification\MetalClassification\Original_Uncut\sample03"];

    EnhanceUncutName = ["D:\216\ECE515\Texture_Classification\MetalClassification\Enhanced_Cutted\1", ... 
        "D:\216\ECE515\Texture_Classification\MetalClassification\Enhanced_Cutted\2", ... 
        "D:\216\ECE515\Texture_Classification\MetalClassification\Enhanced_Cutted\3"];

    UnEnhanceSet = imageDatastore(UnEnhanceUncutName,"LabelSource","foldernames");
    EnhanceSet = imageDatastore(EnhanceUncutName,"LabelSource","foldernames");
end
