function FeatureVec = BlockFeat(Img,Filter)
    % Perform DWT
    if (size(Img,3) == 3)
        Img = rgb2gray(Img);
        Img = im2double(Img);
    end
    SampleSize = size(Img);
    
    FilterBank = {'db2','db2','db2'};
    if nargin < 2
        Filter = FilterBank;
    end
    FeatureVec = zeros([1,21],'double');
    [L1LL, L1LH, L1HL, L1HH] = dwt2(Img,string(Filter(1)));
    [L2LL,L2LH,L2HL,L2HH] = dwt2(L1LL,string(Filter(2)));
    [L3LL,L3LH,L3HL,L3HH] = dwt2(L2LL,string(Filter(3)));
    % Obtain M1,M2,M3
    M1s = (L1LH.*L1LH + L1HL.*L1HL).^0.5;
    M2s = (L2LH.*L2LH + L2HL.*L2HL).^0.5;
    M3s = (L3LH.*L3LH + L3HL.*L3HL).^0.5;
    Max = SampleSize(1)*SampleSize(2);
    
    M1min = min(min(M1s));
    M1max = max(max(M1s));
    M1 = (M1s - M1min).*(Max/(M1max-M1min));
    
    M2min = min(min(M2s));
    M2max = max(max(M2s));
    M2 = (M2s - M2min).*(Max/(M2max-M2min));
    
    M3min = min(min(M3s));
    M3max = max(max(M3s));
    M3 = (M3s - M3min).*(Max/(M3max-M3min));
    
    %%Obtain LRI1
    L1LLmin = min(min(L1LL));
    L1LLmax = max(max(L1LL));
    LRI1 = (L1LL - L1LLmin).*(Max/L1LLmax - L1LLmin);
    
    %%Obtain LRI1
    L2LLmin = min(min(L2LL));
    L2LLmax = max(max(L2LL));
    LRI2 = (L2LL - L2LLmin).*(Max/L2LLmax - L2LLmin);
    
    %%Obtain LRI1
    L3LLmin = min(min(L3LL));
    L3LLmax = max(max(L3LL));
    LRI3 = (L3LL - L3LLmin).*(Max/L3LLmax - L3LLmin);
    
    %%Obtain Features filters hyperparameters need to be adjusted
    h1 = fspecial('log',3,2);
    h2 = fspecial('laplacian',0);
    h3 = fspecial('gaussian',3,5);

    %May use imfilter(LRI1,h,'full');
    LLfilter1 = conv2(LRI1,h1,'valid');
    LLfilter2 = conv2(LRI1,h2,'valid');
    LLfilter3 = conv2(LRI1,h3,'valid');
    LLfilter4 = stdfilt(LRI1);
    LRISize = Max/4;
    
    FeatureVec(1) = norm(LLfilter1,1)/LRISize;
    FeatureVec(2) = norm(LLfilter2,1)/LRISize;
    FeatureVec(3) = norm(LLfilter3,1)/LRISize;
    FeatureVec(4) = norm(LLfilter4,1)/LRISize;
    FeatureVec(5) = std(LLfilter1,1,"all");
    FeatureVec(6) = std(LLfilter2,1,"all");
    FeatureVec(7) = std(LLfilter3,1,"all");
    FeatureVec(8) = std(LLfilter4,1,"all");
    FeatureVec(9) = graythresh(LLfilter1);%Add a max scalar
    
    % From M1
    FeatureVec(10) = graythresh(M1)*norm(M1,1)/(LRISize);
    FeatureVec(13) = entropy(reshape(M1./Max,[1,size(M1,1)*size(M1,2)]));
    
    % From M2
    FeatureVec(11) = graythresh(M2)*norm(M2,1)/(Max/16);
    FeatureVec(14) = entropy(reshape(M2./Max,[1,size(M2,1)*size(M2,2)]));
    
    % From M3
    FeatureVec(12) = graythresh(M3)*norm(M3,1)/(Max/64);
    FeatureVec(15) = entropy(reshape(M3./Max,[1,size(M3,1)*size(M3,2)]));
    
    % From LRI1
    FeatureVec(16) = graythresh(LRI1)*norm(LRI1,1)/(Max/4);
    FeatureVec(19) = entropy(reshape(LRI1./Max,[1,size(LRI1,1)*size(LRI1,2)]));
    
    % From LRI2
    FeatureVec(17) = graythresh(LRI2)*norm(LRI2,1)/(Max/16);
    FeatureVec(20) = entropy(reshape(LRI2./Max,[1,size(LRI2,1)*size(LRI2,2)]));
    
    % From LRI3
    FeatureVec(18) = graythresh(LRI3)*norm(LRI3,1)/(Max/64);
    FeatureVec(21) = entropy(reshape(LRI3./Max,[1,size(LRI3,1)*size(LRI3,2)]));

end

