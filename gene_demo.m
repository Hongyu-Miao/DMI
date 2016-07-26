%In case of the environment problem
clear all;
close all;

fprintf('DMI method starts:\n');

ts = importdata('X.mat');
gsd = importdata('bg.mat');
[N, T] = size(ts);

D = (ts(:,2:T)-ts(:,1:(T-1)));
X = ts(:,1:(T-1));

% amount of iterations and control the penalty of l21 norm and l1 norm with different alpha and beta respectively.
K = 1000;
alpha = 0.081; beta = 0.22;

% ADMM method solves this problem and then give the prediction A1
A1 = ADMM2AFast(D,X,N,alpha,beta,K,gsd,gsd);
% if there could be non-positive number in the practical case ,please
% delete abs

load('FromID.mat');% this file contains array 'a'
load('ToID.mat');% this file contains array 'b'
load('name.mat');
f1 = fopen('scores_edges_filtered.txt','w+');
for i = 1:length(a)
    namea = strsplit(name{a(i)}, '\t');
    nameb = strsplit(name{b(i)}, '\t');
    fprintf(f1,'%s\t%s\t%s\t%s\t%f\n',namea{1},namea{2},nameb{1},nameb{2},full(A1(b(i),a(i))));
end
fclose(f1);
