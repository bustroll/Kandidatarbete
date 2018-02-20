function procent = CleanArea()
    global gridSize;
    
    procent = nnz(gridSize)/numel(gridSize);
end
    