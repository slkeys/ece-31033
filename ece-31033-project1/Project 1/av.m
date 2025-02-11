function avg = av(waveform, T, dt)
    samples = round(T / dt);
    avg = sum(waveform(end - samples : end)) / samples;
end