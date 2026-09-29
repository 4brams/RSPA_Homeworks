function [t, f, sunspotMA, sunspotSpectrum, filterSystemResponse, sunPeriod] = processData(sunspotNum, period, point, delta_t)
    N = length(sunspotNum);
    margin = floor(point / 2);

    t = period((margin + 1) : (end - margin));
    f = ((-N / 2) : 1 : (N / 2 - 1)) / (delta_t * N);

    filter = zeros(1, point);
    for i = 1 : point
        filter(i) = 1 / i;
    end

    sunspotMA = conv(sunspotNum, filter, "valid");
    sunspotSpectrum = abs(fftshift(fft(sunspotMA - mean(sunspotMA), N)));
    filterSystemResponse = abs(fftshift(fft(filter, N)));

    [val, idx] = max(sunspotSpectrum);
    sunPeriod = abs((1 / (f(idx))) / 12);
end