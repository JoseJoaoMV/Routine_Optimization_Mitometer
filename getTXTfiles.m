function filelist=getTXTfiles()
%getTXTfiles creates a cell array of all the TXT file names in the current
%folder.
%   Input not required
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

currentFolder=pwd;
listing=dir(currentFolder);
listing=struct2cell(listing);
allfileslist=listing(1,:);
string2find = 'txt';

for n=1:length(allfileslist)
if contains(char(allfileslist(n)),'txt')==1
filelist(n)=allfileslist(n);
end
end

if exist('filelist','var'); % Prevent the function from giving an empty output
ind = find(cellfun(@ischar,filelist) == 1);
filelist=filelist(ind);
else
    error('TXT files not found in this directory.')
end
end