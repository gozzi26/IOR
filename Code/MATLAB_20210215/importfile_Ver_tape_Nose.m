function VeronicatapeNose = importfile_Ver_tape_Nose(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  VERONICATAPENOSE = IMPORTFILE(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the numeric data.
%
%  VERONICATAPENOSE = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  VERONICATAPENOSE = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  VeronicatapeNose = importfile_Ver_tape_Nose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_04-Veronica_tape_Nose.xlsx", "2021_03_04-Veronica_tape_Nose", [2, 1469]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 04-Mar-2021 19:31:07

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 1469];
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
VeronicatapeNose = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":B" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    VeronicatapeNose = [VeronicatapeNose; tb]; %#ok<AGROW>
end

%% Convert to output type
VeronicatapeNose = table2array(VeronicatapeNose);
end