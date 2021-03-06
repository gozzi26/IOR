function AllisonTapeNose = importfile0311_All_Tape_Nose(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  ALLISONTAPENOSE = IMPORTFILE(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the numeric data.
%
%  ALLISONTAPENOSE = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  ALLISONTAPENOSE = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  AllisonTapeNose = importfile0311_All_Tape_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_11-Allison_Tape_Nose.xlsx", "2021_03_11-Allison_Tape_Nose", [2, 2770]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 11-Mar-2021 15:29:00

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 2770];
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
AllisonTapeNose = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":B" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    AllisonTapeNose = [AllisonTapeNose; tb]; %#ok<AGROW>
end

%% Convert to output type
AllisonTapeNose = table2array(AllisonTapeNose);
end