%init
close all;
clear all;
clc;

%config
FILE_NAME = "SN_m_tot_V2.0.txt";
DELTA_T = 1;
LINE_WIDTH = 0.1;
FIGURE_WIDTH = 3000;
FIGURE_HEIGHT = 2000;

points = [1, 5, 9, 13];
%points = 1:10:2001;
%points = [1, 49, 299, 699];
T = [];

%main
fig1 = figure("Position", [0, 0, FIGURE_WIDTH, FIGURE_HEIGHT]);
hold on;
fig2 = figure;
hold on;

[sunspotNum, period, sizeofData] = readData(FILE_NAME);

idx = 0;
for point = points
    [t, f, sunspotMA, sunspotSpectrum, filterSystemResponse, T(end + 1)] = processData(sunspotNum, period, point, DELTA_T);

    figure(fig1);

    subplot(length(points), 3, idx * 3 + 1);
    plot(t, sunspotMA, LineWidth = LINE_WIDTH);
    grid on;
    xlim([min(t), max(t)]);
    xlabel("Time(Month)");
    ylabel("Sunspots");
    title(point + "-MA Sumspots Number");

    subplot(length(points), 3, idx * 3 + 2);
    plot(f, sunspotSpectrum, LineWidth = LINE_WIDTH);
    grid on;
    xlim([-0.035, 0.035]);
    xlabel("Frequency");
    ylabel("Magnitude");
    title("Spectrum of " + point + "-MA Sumspots Number (T=" + T(end) + "years)");

    subplot(length(points), 3, idx * 3 + 3);
    plot(f, filterSystemResponse, LineWidth = LINE_WIDTH);
    grid on;
    xlabel("Frequency");
    ylabel("Magnitude");
    title(point + "-Point Filter System Response");

    figure(fig2);

    subplot(length(points), 1, idx + 1);
    yyaxis left;
    plot(f, sunspotSpectrum)
    grid on;
    ylabel('Sunspot');
    yyaxis right;
    plot(f, filterSystemResponse)
    grid on;
    ylim([0, 8]);
    ylabel('SystemResponse');
    xlabel("Frequency");
    xlim([-0.1, 0.1]);
    title(point + "-Point Spectrum and SR(T=" + T(end) + "years)");

    idx = idx + 1;

    disp(point);
end

fig3 = figure;
plot(points, T);
xlim([min(points), max(points)]);
grid on;
xlabel("Points");
ylabel("Period");
title("Period of Different Points");

%save
saveas(fig1, "Figure1.png");
saveas(fig2, "Figure2.png");
saveas(fig3, "Figure3.png");