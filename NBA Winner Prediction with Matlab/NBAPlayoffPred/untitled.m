url = 'https://www.basketball-reference.com/leagues/NBA_2015.html';
code = webread(url);
txt = regexp(code,'<table.*?/table>', 'match');
miscStatsCode = txt{24};
miscStatsTree = htmlTree(miscStatsCode);
% Get variable names
headerCode = regexp(miscStatsCode,'<thead.*?/thead>', 'match');
top = regexp(headerCode{1},'<tr.*?/tr>', 'match');
colnames = strsplit(strtrim(extractHTMLText(top{2})));

tbodyCode = regexp(miscStatsCode,'<tbody.*?/tbody>', 'match');
tbodyTree = htmlTree(tbodyCode);
temp = findElement(tbodyTree, "TR");


for i = 1:length(temp)
    for j = 1:length(temp(i))
           extractHTMLText(temp(i).Children(j));
    end
end
% colnames = regexp(top{2},'<th.*?/th>', 'match');

