clc,clear,close all;
%% Load the dataset
%Brodats directory
Location = "D:\216\ECE515\Texture_Classification\rotate";

%CURET Unenhanced directory
%Location = "D:\216\ECE515\Texture_Classification\MetalClassification\Original_Cutted";

%CURET Enhanced directory
%Location = "D:\216\ECE515\Texture_Classification\MetalClassification\Enhanced_Cutted";

Dataset = imageDatastore(Location);
Files = Dataset.Files;
PicsCell = readall(Dataset);

%ImageSet information 
%Brodats use 512 size, CURET use 256 size
%Imagesize = 512;
Imagesize = 512;
%Brodats use 7 and 13 CURET use 38 and 3
SingleInClassNum = 7;
TotalClasses = 13;
TotalImageNum = SingleInClassNum*TotalClasses;

ResizeScalar = 1;

%Sample length is optimized to be 128 at Brodats Dataset CURET use 32
SampleLength = 64;

SingleLoopNum = (Imagesize*ResizeScalar)/SampleLength;
Featuresall = zeros([21,SingleLoopNum^2*TotalImageNum],'double');
Response = zeros([1,SingleLoopNum^2*TotalImageNum],'double');
for i = 1:TotalClasses
    for j = 1:SingleInClassNum
        index = type2index(i,SingleInClassNum);
        index = index(j);
        img = cell2mat(PicsCell(index));
        img = im2double(img);
        img = imresize(img,ResizeScalar);
        for iimage = 0:1:SingleLoopNum-1
            for jimage = 0:1:SingleLoopNum-1
                subimage = img(SampleLength*iimage+1:(SampleLength*iimage ...
                    +SampleLength), SampleLength*jimage + ... 
                    1:SampleLength*jimage + SampleLength);
                Feature = BlockFeat(subimage);
                Featuresall(:,SingleLoopNum^2*(index-1)+ iimage*SingleLoopNum+ ...
                    jimage+1) = Feature';
                Response(SingleLoopNum^2*(index-1)+ iimage*SingleLoopNum+ ...
                    jimage+1) = i;
            end
        end
    end
end
Featuresall = Featuresall';
Aggregate = [Featuresall,Response'];
TableName = ["Feat1","Feat2","Feat3","Feat4","Feat5","Feat6", ...
    "Feat7","Feat8","Feat9","Feat10","Feat11","Feat12","Feat13","Feat14","Feat15", ...
    "Feat16","Feat17","Feat18","Feat19","Feat20","Feat21","Type"];

AllData = array2table(Aggregate,"VariableNames",TableName);
save('Alldata.mat');
classificationLearner