# DMI
Decomposable Multi-structure Identification Algorithm for large-scale Gene Regulatory Network (GRN) inference. 

1. run "gene_real_data_demo.m" to prepare your data for DMI input;
2. run "gene_demo.m" to do the calculation;

## FORMATS FOR INPUT FILES
The DMI method requires three input files: one gene expression data file and two background network files. 

1. Gene expression data file (GEDF): this file contains a T-by-N matrix, where T is the number of time points in the experiment and N is the number of genes. For simplicity, you can run "gene_real_data_demo.m" to convert a .csv file to a GEDF, and we provide an example data file called "GSE36553_36461_processed_filtered.csv" for users to understand the format.

2. Background network file (BNF): You need to provide one file for edges (format: Symbol_1 ID_1 Symbol_2 ID_2) and one file for nodes (format: ID Symbol). Please see "human.edge.txt" and "human.node.txt" for details.

## FORMATS FOR OUTPUT FILES
The output will be named "scores_edges_filtered.txt" in the following format: ID_1 Symbol_1 ID_2 Symbol_2 Edge_coefficient. 

## SYSTEM REQUIREMENTS
Currently the code has been tested using 64-bit MATLAB 2016a on a Mac machine with 16GB memory. If you encounter any memory error, our suggestion is to 1) increase the system memory to 16GB; 2) switch to a 64-bit operating system as well as a 64-bit version of MATLAB. 
