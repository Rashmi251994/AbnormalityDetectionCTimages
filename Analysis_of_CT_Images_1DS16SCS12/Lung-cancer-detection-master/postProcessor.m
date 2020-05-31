function cancerous = postProcessor(noduleimg)

%% extract features from the nodule image
% need to reconsider this
entropyOfImg = entropy(noduleimg);
energyOfImg = sum(noduleimg(:));

%% post process the nodules
% find the length of each nodules in the lung region
nodules = regionprops(noduleimg, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');
% consider nodules with max length larger than or equal 3.3 
cancerous = [];
maxindex = [nodules.MajorAxisLength] >=3.3;
minindex = [nodules.MinorAxisLength] >1;
index = maxindex .* minindex;
for i = 1: length(index)
    if index(i) == 1
        temps = nodules(i);
        cancerous = [cancerous; temps];
    end
end

end

