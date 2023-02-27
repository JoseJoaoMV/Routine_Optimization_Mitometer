function dados=mitometer2table(filename,opts1)
%mitometer2table takes a .TXT file and converts it to a MatLab table and excel
%file.
%   filename should be a cell vector containing the file names along with
%   the extensions.
%   getTXTfiles function could be used as the input of this function to get
%   the data from all TXT files in the current folder.
%
%   The last column corresponds to the mean of the entire row, and the last
%   row contains only one number that is the mean of the entire last column.
%
% Copyright:
%
% Author: Vinícius Gabriel Martins de Paula
% Supervised by Dr. Diogo Trigo
%
% Project within the scope of the 4th edition of Maria de Sousa Summer
% Research Program. Project promoted by the ATG (All Time GABBAs)
% Association, in collaboration with iBiMED: Institute of Biomedicine,
% from the Department of Medical Sciences - University of Aveiro and
% support from the American Portuguese Biomedical Research Fund.
%
% Aveiro, 2022

funerror = iscell(filename); % Check input

if funerror == 0
    error('Function input must be a cell vector containing the file names along with extensions! (help mitometer2table)');
    return
end

dados=cell(filename); % alocate memory
disp(' '); % clarify the command window output

for k = 1:length(filename)
    if isfile(char(filename(k)))==0 % Check if file exists in current folder
        error('No such file or directory. Check if file is in the same folder.');
        return
    end
    M=readmatrix(char(filename(k)));
    s1 = char(filename(k));
    s = s1(10:(end-4));
    if opts1==1
        writematrix(M,'data.xlsx','Sheet',s) % Write data to excel file
    end
    M(isnan(M))=0;
    for n=1:length(M(:,1))
        rowmean(n)=mean(nonzeros(M(n,:)));
    end
    avgmean=mean(rowmean);
    s1 = char(filename(k));
    s2 = '.xlsx';
    s = strcat(s1(10:(end-4)),s2);
    fprintf('File %s - Mean: %4.2f \n',s1(1:(end-4)),avgmean)
    writematrix(avgmean,'mean.xlsx','Sheet',s) % Write data to excel file
    dados{k}=M;
end
M(end,:)=zeros(1,length(M(1,:)));
for N=1:length(M(1,:))
    M(end,N)=length(nonzeros(M(:,N)));
end
newM=M(end,:);
for N=1:length(M(1,:))-1
    newM(N+1)=M(end,N+1)-M(end,N);
end
writematrix(M(end,:),'count.xlsx','Sheet','Count per frame') % Write data to excel file
writematrix(newM,'count.xlsx','Sheet','Variation per frame') % Write data to excel file
end