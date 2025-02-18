function varout = varcat(workspaces, varname, direction, normoption, normfactor)

%%%

% To concatenate a series of (the same) variables from different workspaces

% INPUT:
% workspace : cell of strings, directory of different workspaces
% varname : string, name of target variables (assume the same)
% direction : "vert" (vertical) or "horz" (horizontal)
% normoption: 0 or 1, pre-normalize or not
% normfactor: if normoption=1, normfactor is by default (i.e., [])
%   the mean value of the varaible (n-by-1 double) in each workspace;
%   or (if not empty): a double array with the same length of "workspaces"
%   that contains a user-defined pre-normalization factor specific to wksp

% OUTPUT:
% varout : concatenated var in all workspaces

% Example
% a = [1;2;3] in "wks1.mat"
% a = [2;3;4] in "wks2.mat"
% a = [1;1;1] in "wks3.mat"
% b = varcat( {'wks1.mat','wks2.mat','wks3.mat'},...
%             'a', 'vert', 1, [])
% will output b = [0.50;1.00;1.50; 0.67;1.00;1.33; 1.00;1.00;1.00]


% Zhaohong Wang
% Cornell University
% 18 Feb 2025

%%%

num = length(workspaces);

combo = cell(num,1);

for ii = 1:num
    thisvar = load(workspaces{ii},varname);
    thisvar = thisvar.(varname);
    if isa(thisvar,'double') & normoption == 1
        if isempty(normfactor)
            combo{ii} = thisvar./mean(thisvar);
        else
            combo{ii} = thisvar./normfactor(ii);
        end
    else
        combo{ii} = thisvar;
    end
end

if direction == 'vert'
    varout = vertcat(combo{:});
elseif direction == 'horz'
    varout = horzcat(combo{:});
else
    warning('Define how to concatenate variables')
end
