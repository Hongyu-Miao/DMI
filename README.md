# DMI
Decomposable Multi-structure Identification Algorithm for large-scale Gene Regulatory Network (GRN) inference. 

1. run "gene_real_data_demo.m" to prepare your data for DMI input;
2. run "gene_demo.m" to do the calculation;

## FORMATS FOR INPUT FILES
DMI core method ADMM2AFast.m requires two input files, gene expression data file and background network file. 

1. Gene expression data file (GEDF): this is a .mat file which is the standard data file in MATLAB. In one GEDF, it contains a T-by-N matrix. T is the amount of time points in the experiment and N represents the number of genes considered. This file works as the input of DataIntroSP.m and it will be converted to the input data used by ADMM2AFast.m which are D and X. D is the difference of gene expression between two adjacency time points which is an N-by-(T-1) matrix. And X is the original expression data without the last gene expression levels which is an N-by-(T-1) matrix, too.
2. Background network file (BNF): this is a .tsv file which the the formal format file used by GeneNetWeaver. Each line record denotes one edge in the net. The first two elements are names of nodes of this edge. The arrow direction of one edge is from the first item to the second one. The third item denotes the existence of this edge. 1 means yes, 0 means not. 

## FORMATS FOR OUTPUT FILES
ADMM2AFast.m only output the result to the workspace. If you want to save the result for evaluation or future exploration, please save the output matrix A as the format you'd like.

A is a N-by-N square matrix which represent the full network we reconstruct. The directions of edges in the net are from the column indexes to the row ones. The value of the element corresponding to each position denotes the possibility of the existence of such edge. The higher value means more possible existing. 
