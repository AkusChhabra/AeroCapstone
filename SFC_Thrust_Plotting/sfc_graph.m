clc; clear; close all;

%% Obtain data from file

file = importdata("RamFalcon2000.xlsx")

%% Variable definitions

data = strings(0);
alt = [];
isa = [];
spds = [];
FIN = [];
thrust = [];
SFC = [];

%% Store data in array

for i = 1:length(file.data.RamFalcon2000_Cruise(:,1))
    if isnan(file.data.RamFalcon2000_Cruise(i,1)) == 0
        str = string(file.data.RamFalcon2000_Cruise(i,:));
        str = strjoin(str);
        data(end+1) = str;
        split = strsplit(str);
        alt(end+1) = double(split(1));
        isa(end+1) = double(split(2));
        spds(end+1) = double(split(3));
        FIN(end+1) = double(split(4));
        thrust(end+1) = double(split(5));
        SFC(end+1) = double(split(6));
    end
end

%% Plot data

inc = 10;
fig_define = true;
for i = 1:inc:length(data)
    if fig_define
        fig = figure(i)
        title(sprintfc('SFC vs. Thrust at %d ft', alt(i)))
        grid on
        grid minor
        legend show
        legend('Location','eastoutside')
        fig_define = false;
        xlabel('Thrust (lbf)') 
        ylabel('SFC (PPH/lbf)')
        hold on
    end
    if i ~= length(data)-inc+1 && alt(i) == alt(i+inc) && ~fig_define
        x = thrust(i:i+inc-1);
        y = SFC(i:i+inc-1);
        plot(x,y,'o-','linewidth',0.5,'markersize',5,'markerfacecolor','g','DisplayName', sprintf('Mach %.2f',spds(i)))
        hold on
    end
    if i ~= length(data)-inc+1 && alt(i) ~= alt(i+inc) && ~fig_define
        x = thrust(i:i+inc-1);
        y = SFC(i:i+inc-1);
        plot(x,y,'o-','linewidth',0.5,'markersize',5,'markerfacecolor','g','DisplayName', sprintf('Mach %.2f',spds(i)))
        fig_define = true;
        filename = ['Alt_'  num2str(alt(i))]
        saveas(fig, filename, 'png')
    end
    if i == length(data)-inc+1
        x = thrust(i:length(data));
        y = SFC(i:length(data));
        plot(x,y,'o-','linewidth',0.5,'markersize',5,'markerfacecolor','g','DisplayName', sprintf('Mach %.2f',spds(i)))
        hold off
        filename = ['Alt_'  num2str(alt(i))]
        saveas(fig, filename, 'png')
    end
end
