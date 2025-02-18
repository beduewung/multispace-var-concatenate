function varout = varcat(workspaces, varname, direction, normoption, normfactor)

%%% to concatenate a series of variables
% from different workspaces
% workspace = cell of strings, directory of different workspaces
% varname = string, name of target variables (assume the same)
% option = "vert" (vertical) or "horz" (horizontal)

num = length(workspaces);

combo = cell(num,1);

for ii = 1:num
    thisvar = load(workspaces{ii},varname);
    thisvar = thisvar.(varname);
    if isa(thisvar,'double') & normoption == 1
        if isempty(normfactor)
            combo{ii} = thisvar./mean(thisvar);
        else
            combo{ii} = thisvar./normfactor(jj);
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