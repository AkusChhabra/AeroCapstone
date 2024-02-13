clear; clc; close all;
% Note all parameters are in imperial units.

%% Weight Definitions

W_spax = 250;
num_pass = 6;
W_pax = 6*W_spax;
W_baggage = 250;
W_reserve = 1000;
W_fuel = 1000;
W_payload = W_pax + W_baggage + W_spax;
OEW = 6500;

GWT = OEW + W_fuel + W_reserve + W_payload;
MTO = 12000;
if GWT > MTO
    error('GWT greater than MTO. Revise weights.')
end

% Temp line --> to be removed after finalizing MTO
GWT = MTO;

%% Geometric Defintions

span = 32; 

%% Read file

file = importdata("RamFalcon2000.xlsx");
table_MTO = readtable("RamFalcon2000.xlsx","Sheet","RamFalcon2000_MTO");

%% Main

% Takeoff Segment

ALT = 0;
ISA = 0;
SPD_SETTING = 'MTO';
SFC_arr = [];
WF_arr = [];
FNIN_arr = [];

if SPD_SETTING == 'MTO'
    for i = 0.1:0.1:0.4
        [SFC, WF, FNIN] = readData(ALT,ISA,i, table_MTO);
        SFC_arr(end+1) = SFC;
        WF_arr(end+1) = WF;
        FNIN_arr(end+1) = FNIN;
    end
end

% Climb Segment

% Cruise Segment

% Descent Segment

% Approach Segment

% Possible Diversion using reserve fuel
