function  [SFC, WF, FNIN] = readData(ALT,ISA,MCH, table)
    data = table(table.ALT == ALT & table.DTAMB == ISA & table.MACH == MCH,:);
    SFC = data.SFC;
    WF = data.WF;
    FNIN = data.FNIN;
end
