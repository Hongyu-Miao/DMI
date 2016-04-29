function [ SN,SP,ACC,Fmeasure,MCC,auc ] = evaluationF( A0,gsd,BgNet,N )
%   A0  : recovery gene network
%   gsd : ground truth N-by-N
%   BgNet: Background network N-by-N
%   N: Size of network
seq1 = TopNinMatrix(abs(A0),sum(sum(gsd)));
MAP = sparse(seq1(:,2),seq1(:,3),ones(1,length(seq1)),N,N);
% MAP = zeros(N,N);
% for i = 1:size(seq1,1)
%     MAP(seq1(i,2),seq1(i,3))=1;
% end
% 
% l  = sum(sum(BgNet));
% 
% targets = zeros(1,l);
% outputs = zeros(1,l);
% 
% tep = 1;
% 
% for i = 1:N
%     for j = 1:N
%         if BgNet(i,j) == 1
%             if gsd(i,j) == 1
%                 targets(tep) = 1;
%             end
%             if MAP(i,j) == 1
%                 outputs(tep) = 1;
%             end
%             tep = tep +1 ;
%         end
%     end    
% end
% [X,Y,T,auc] = perfcurve(targets,outputs,1);
% figure(44);
% plot(X,Y);

[X,Y,T,auc] = perfcurve(gsd(BgNet == 1),MAP(BgNet == 1),1);
%auc = plot_roc( outputs, targets );

% Diff1 = find((MAP(:)==gsd(:)) & (MAP(:)==1));
% 
% [overlap1,v1] = size(Diff1(:,1));
% 
% total1 = sum(gsd(:));
% 
% ratio1 = overlap1/total1;

% fprintf('A0 overlap ratio is %f\n',ratio1);
% figure(1);
% subplot(2,2,3);
% imshow(MAP==0,'InitialMagnification','fit');
% subplot(2,2,4);
% imshow(gsd==0,'InitialMagnification','fit');


%SN
TPMatrix = zeros(N,N);%True positive
TPMatrix((MAP > 0) & (gsd == 1)) = 1;
FNMatrix = zeros(N,N);%False negative
FNMatrix((MAP == 0) & (gsd == 1)) = 1;
TP = sum(sum(TPMatrix));
FN = sum(sum(FNMatrix));

SN = TP/(TP+FN);
% fprintf('SN = SN/(TP+FN) = %f\n', SN);


%SP
TNMatrix = zeros(N,N);%True Negative
TNMatrix((MAP == 0)&(gsd == 0)&(BgNet == 1)) = 1;
FPMatrix = zeros(N,N);%False Positive
FPMatrix((MAP == 1)&(gsd == 0)) = 1;

TN = sum(sum(TNMatrix));
FP = sum(sum(FPMatrix));

SP = TN/(TN+FP);
% fprintf('SP is %f\n', SP);


%ACC
ACC = (TP+TN)/(TP+TN+FN+FP);
% fprintf('ACC is %f\n', ACC);


%F-measure
Fmeasure = 2*(SN*SP)/(SN+SP);
% fprintf('Fmeasure is %f\n', Fmeasure);


%MCC
MCC = (TP * TN - FP * FN)/sqrt((TP+FN)*(TP+FP)*(TN+FP)*(TN+FN));

% fprintf('MCC is %f\n', MCC);

end

