clc;
close all;
GeneMap = containers.Map(ID,1:length(ID));
a = FromID;
b = ToID;
for i = 1:length(FromID)
    a(i) = GeneMap(FromID(i));
end
for i = 1:length(ToID)
    b(i) = GeneMap(ToID(i));
end
checkFrom = unique(FromID);
checkTo = unique(ToID);
FromMap = containers.Map(checkFrom,1:length(checkFrom));
ToMap = containers.Map(checkTo, 1:length(checkTo));
Tabel = zeros(length(a),3);
Tabel(1:length(a),1) = a;
Tabel(1:length(b),2) = b;
Tabel(1:length(a),3) = 1;

% index = length(a)+1;
% for i = 1:length(ID)
%     for j = 1:length(ID)
%         if ~(isKey(FromMap,i) && isKey(ToMap,i))
%             Tabel(index,1) = i;
%             Tabel(index,2) = j;
%             Tabel(index,3) = 0;
%             index = index + 1;
%             if mod((i*length(ID) + j),length(ID)) == 1
%                 disp(index);
%             end
%         end
%     end
% end
fid = fopen('humanNet','a+');
for i = 1:length(a)
    fprintf(fid,'%d\t%d\t%d\r\n',Tabel(i,1),Tabel(i,2),Tabel(i,3));
    disp(i);
end

fclose(fid);