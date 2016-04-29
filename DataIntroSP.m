function [ gsd, BgNet, D, X ] = DataIntroSP( N )
%Introduce the experiment data from 2 files and 1 user input. 
%   1. groundtruth net file
%   2. time series experiment data
%   gsd : ground truth network N-by-N
%   N   : Size of net. For example we have 50 genes in a subnetwork, then N
%   = 50
%   BgNet: Background network => those potential edges are included in this
%   background network.
%   D   : Differencial data. Our linear system is Y = AX, Then D = Y-X
%   X   : Input time series data

    %Ground Truth
    ngsdfile = fopen(strcat('Yeast',num2str(N),'_goldstandard.tsv'));
    c = textscan(ngsdfile,'%c%d %c%d %d');
    fclose(ngsdfile);
    temp = c{1,5};
    c5 = double(temp(temp~=0));
    temp = c{1,2};
    c2 = double(temp(1:length(c5)));
    temp = c{1,4};
    c4 = double(temp(1:length(c5)));
    gsd = sparse(c4,c2,c5,N,N);
    ts = importdata(strcat('yeast',num2str(N),'_1_ts.mat'));

    BgNet = MaskSimSP(gsd, N*2, N);

     [T, v] = size(ts);

     D = (ts(2:T,:)-ts(1:(T-1),:))';
     X = ts(1:(T-1),:)';


end

