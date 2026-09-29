function [sunspotNum, period, sizeofData] = readData(fileName)
    data = readtable(fileName);
    sizeofData = size(data);
    sizeofData = sizeofData(1);
    
    sunspotNum = data.Var4;
    period = datetime(data.Var1, data.Var2, 1);
end