function index = type2index(type)
if type > 13
    return
end
typer = type -1;
index = zeros([1,7]);
for i = 1:7
    index(i) = typer*7+i;
end
end

