function AllisontapeCOMPLopen = importfile_Alli_tape_COMPLopen(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  ALLISONTAPECOMPLOPEN = IMPORTFILE(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the numeric data.
%
%  ALLISONTAPECOMPLOPEN = IMPORTFILE(FILE, SHEET) reads from the
%  specified worksheet.
%
%  ALLISONTAPECOMPLOPEN = IMPORTFILE(FILE, SHEET, DATALINES) reads from
%  the specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  AllisontapeCOMPLopen = importfile_Alli_tape_COMPLopen("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Allison_tape_COMPLopen.xlsx", "2021_03_04-Allison_tape_COMPLop", [2, 3037]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 04-Mar-2021 18:54:00

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 3037];
end

%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 2);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":B" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2"];
opts.SelectedVariableNames = ["VarName1", "VarName2"];
opts.VariableTypes = ["double", "double"];

% Import the data
AllisontapeCOMPLopen = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":B" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    AllisontapeCOMPLopen = [AllisontapeCOMPLopen; tb]; %#ok<AGROW>
end

%% Convert to output type
AllisontapeCOMPLopen = table2array(AllisontapeCOMPLopen);
end