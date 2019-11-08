function map = loadData()
%LOADDATA Reads in data file

path = importfile('paths.csv', 1, 22);

map = int8(ones(200, 120));

for i = 1:size(path, 1)
    row = path(i, :);
    row = row + ones(size(row));
    map(row(1):row(3),row(2):row(4)) = 0;
end

end

