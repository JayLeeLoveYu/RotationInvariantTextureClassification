clc,clear,close all;
Location = "D:\216\ECE515\Texture_Classification\rotate";
Dataset = imageDatastore(Location);
Files = Dataset.Files;
PicsCell = readall(Dataset);
SampleLength = 64;
SingleLoopNum = 512/64;
Featuresall = zeros([21,SingleLoopNum^2*91],'double');
Response = zeros([1,SingleLoopNum^2*91],'double');
for i = 1:13
    for j = 1:7
        index = type2index(i);
        index = index(j);
        img = cell2mat(PicsCell(index));
        img = im2double(img);
        for iimage = 0:1:SingleLoopNum-1
            for jimage = 0:1:SingleLoopNum-1
                subimage = img(SampleLength*iimage+1:(SampleLength*iimage ...
                    +SingleLoopNum^2), SampleLength*jimage + ... 
                    1:SampleLength*jimage + SingleLoopNum^2);
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