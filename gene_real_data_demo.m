%In case of the environment problem
clear all;
close all;

% import background gene network.
ngsdfile = fopen(strcat('human.edge.txt'));
c = textscan(ngsdfile,'%s %s %s %s');
fclose(ngsdfile);

ngsdfile2 = fopen(strcat('human.node.txt'));
c2 = textscan(ngsdfile,'%s','Delimiter',' ');
fclose(ngsdfile2);
name = c2{1};
GeneMap = containers.Map;
for i = 1:length(name)
    t = strsplit(name{i},'\t');
    GeneMap(t{1}) = i;
end

FromID = c{2};
a = zeros(1,length(FromID));
ToID = c{4};
b = zeros(1,length(ToID));
for i = 1 : length(a)
    a(i) = GeneMap(FromID{i});
    b(i) = GeneMap(ToID{i});
end

% size of background network
N = length(c2{1});
% build background network with sparse structure
bg = sparse(b,a,ones(1,length(a)),N,N);

% read the expression data
ngsdfile = fopen('GSE36553_36461_processed_filtered.csv');
m = textscan(ngsdfile,'%s %s %f %f %f %f %f %f','Delimiter',',','HeaderLines',1);

% put the data in the same order as in the node file
dataMap = containers.Map(m{1},1:length(m{1}));

X = zeros(N,6);
dv = cell2mat(m(3:end));

for i = 1:N
    t = strsplit(name{i},'\t');
    if isKey(dataMap,t{1})
        X(i,:) = dv(dataMap(t{1}),:);
    end
end

save('FromID.mat','a');
save('ToID.mat','b');

% list of all genes in human.node.txt
save('name.mat','name');

% save background
save('bg.mat','bg');

% save exp data
% for those gene can not be found in human.node.txt, the corresponding line
% is all zero.
save('X.mat','X');