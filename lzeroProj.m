function [ A ] = lzeroProj( varargin)
               A = varargin{1};
               gsd = varargin{2};
               copyA = abs(A);
               N = length(A);
               P = ceil(sum(gsd,2)*0.7);
               for i = 1:N
                   [row,col,v] = find(copyA(i,:));

                   [Y,I] = sort(v,'descend');
                    A(i,col(I(P(i)+1:end))) = 0;
               end



end

