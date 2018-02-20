clear all
clf
clc

nbrOfRuns = 10;
saveData = zeros(nbrOfRuns, 4);
for run = 1:nbrOfRuns
    ResetGlobalVar();
    InitializePostion();
    InitializeTheta();
    vector = InitializeRV();
    data = Path(vector);
    
    saveData(run,:) = data;
    summa = sum(saveData)/nbrOfRuns;
    medelTurn = summa(1);
    medelTime = summa(2);
    medelPathLength = summa(3);
    medelProcent = summa(4);
    disp(['Medel Turn: ', num2str(medelTurn)])
    disp(['Medel Time: ', num2str(medelTime)])
    disp(['Medel Path Length: ', num2str(medelPathLength)])
    disp(['Medel Procent: ', num2str(medelProcent)])
end