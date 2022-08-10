fileName = "2012-18_teamBoxScore.csv";
boxScores = readNBAData(fileName, 2);
%-----------------------------------------------
simpleScores = boxScores(:,{'teamAbbr','opptAbbr', 'teamConf', 'teamLoc',...
    'teamRslt','teamEFG','teamFIC','teamAST','teamTO','team3P','teamDRB',...
    'teamORB'});
%-----------------------------------------------
p = .5;      % proportion of rows to select for training
N = size(simpleScores,1);  % total number of rows
tf = false(N,1);  % create logical index vector
tf(1:round(p*N)) = true;
tf = tf(randperm(N));   % randomise order
dataTraining = simpleScores(tf,:);
dataTesting = simpleScores(~tf,:);
%-----------------------------------------------
dataTestingP = dataTesting;
dataTestingP(:,"teamRslt") = [];
%-----------------------------------------------

teamRsltTrain = table2array(dataTraining(:,"teamRslt"));
%svmLin = fitclinear(dataTraining, teamRsltTrain, 'KFold',5, 'Learner','logistic','Solver','sparsa','Regularization','lasso');
svmGau = fitcsvm(dataTraining,teamRsltTrain,'Standardize',true,'KernelFunction','gaussian');
