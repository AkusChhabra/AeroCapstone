clear; clc; close all;
% Note all parameters are in imperial units.

%% Weight Definitions

W_spax = 200;
num_pass = 7;
W_pax = num_pass*W_spax;
W_single_bag = 40;
W_baggage = 40*num_pass;
W_reserve = 1000;
W_fuel = 2000;
W_payload = W_pax + W_baggage + W_spax;
OEW = 4400; % 6000

GWT = OEW + W_fuel + W_reserve + W_payload;
MTO = 8500;
%if GWT > MTO
%    error('GWT greater than MTO. Revise weights.')
%end

% Temp line --> to be removed after finalizing MTO
GWT = MTO;

%% Geometric Defintions

g = 32.2;
TW_ratio = 0.47; % ma/mg
span = 32; 
num_eng = 2;

%% Read file

file = importdata("RamFalcon2000.xlsx");
table_MTO = readtable("RamFalcon2000.xlsx","Sheet","RamFalcon2000_MTO");
table_CLB = readtable("RamFalcon2000.xlsx","Sheet","RamFalcon2000_MCL");
table_CRZ = readtable("RamFalcon2000.xlsx","Sheet","RamFalcon2000_Cruise");

%% Main

% Taxi Segment

W_taxi = W_fuel*0.05;
W_fuel = W_fuel - W_taxi;

% Takeoff Segment

ALT = 0;
ISA = 0;
SPD_SETTING = 'MTO';
SFC_arr = [0];
WF_arr = [0];
FNIN_arr = [0];

if SPD_SETTING == 'MTO'
    for i = 0.1:0.1:0.4
        [SFC, WF, FNIN] = readData(ALT,ISA,round(i,2),table_MTO);
        SFC_arr(end+1) = SFC;
        WF_arr(end+1) = WF;
        FNIN_arr(end+1) = FNIN;
    end
end

TO_SPDS = [0:0.01:0.4];
SFC_intrp = interp1([0:0.1:0.4],SFC_arr,TO_SPDS); % (lb/hr)/lbf
WF_intrp = interp1([0:0.1:0.4],WF_arr,TO_SPDS); % lbm/hr
FNIN_intrp = interp1([0:0.1:0.4],FNIN_arr,TO_SPDS); % lbf

% 30 second estimate for takeoff
W_fuel_con = 0;
W_fuel_rem = W_fuel;

i = 1;
vi = 0;
gamma = 1.4;
R = 287;
T = 15 + 273; % STP
a = sqrt(gamma*R*T);
inc = 1;
thrust = 2000;
accel = num_eng*thrust*g/(W_fuel_rem + OEW + W_reserve + W_payload)
for t = 1:inc:30 % time from 0 to 30 seconds
    accel = num_eng*interp1(thrust,FNIN_arr,TO_SPDS)*g/(W_fuel_rem + OEW + W_reserve + W_payload)
    v = accel/inc + vi;
    MCH_SPD = v/a;
end

% for i = 1:length(SFC_intrp)
%     accel = num_eng*FNIN_intrp(i)*g/(W_fuel_rem + OEW + W_reserve + W_payload)
%     W_fuel_con = WF_intrp(i)*(1/60/60);
%     W_fuel_rem = W_fuel_rem - W_fuel_con;
% end

W_fuel_consumed = W_fuel - W_fuel_rem; % Assumes constant acceleartion in mach.

% Climb Segment

% ALT_IN = 0; 
% ALT_FIN = 10000;
% ISA = 0;


% Cruise Segment

% ALT = 37000;
% ISA = 0;
% SPD_SETTING = 'CRZ';



% Descent Segment

% Approach Segment

% Possible Diversion using reserve fuel
