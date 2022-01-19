function Me3oralINnoseOUTmouthCLOSED = importfile0302_3_OralANDNose(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  ME3ORALINNOSEOUTMOUTHCLOSED = IMPORTFILE(FILE) reads data from the
%  first worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the numeric data.
%
%  ME3ORALINNOSEOUTMOUTHCLOSED = IMPORTFILE(FILE, SHEET) reads from the
%  specified worksheet.
%
%  ME3ORALINNOSEOUTMOUTHCLOSED = IMPORTFILE(FILE, SHEET, DATALINES)
%  reads from the specified worksheet for the specified row interval(s).
%  Specify DATALINES as a positive scalar integer or a N-by-2 array of
%  positive scalar integers for dis-contiguous row intervals.
%
%  Example:
%  Me3oralINnoseOUTmouthCLOSED = importfile0302_3_OralANDNose("C:\Users\Alessandro\Desktop\Polimi\Chicago Double Degree\5. Thesis\MyCode\MATLAB_20210215\File JSON\2021_03_02-Me3_oralIN+noseOUT(mouthCLOSED).xlsx", "2021_03_02-Me3_oralIN+noseOUT(m", [1, 2653]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 02-Mar-2021 12:03:54

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [1, 2653];
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
Me3oralINnoseOUTmouthCLOSED = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":B" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    Me3oralINnoseOUTmouthCLOSED = [Me3oralINnoseOUTmouthCLOSED; tb]; %#ok<AGROW>
end

%% Convert to output type
Me3oralINnoseOUTmouthCLOSED = table2array(Me3oralINnoseOUTmouthCLOSED);
end