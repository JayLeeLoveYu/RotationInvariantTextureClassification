function index = type2index(type,inclass)
if type > 13
    return
end
typer = type -1;
index = zeros([1,inclass]);
for i = 1:inclass
    index(i) = typer*inclass+i;
end
end

