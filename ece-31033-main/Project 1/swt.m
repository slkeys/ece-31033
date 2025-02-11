% outputs either 1 or 0 for the switch state being ON or OFF
function state = swt(D, t)
    %%  CALCULATIONS
    % initializations
    f_sw = 20000;
    T_sw = 1 / f_sw;
    k_terms = 12; % arbitrary
    tri_wave = 0;
    % normalize T_sw to be [0, 1] for exactly one switch period
    T_norm = mod(t, T_sw) / T_sw;

    % update for the triangle wave, odd harmonics
    for k = 1:2:k_terms
        tri_wave = tri_wave + ((-1)^((k - 1) / 2) * sin(2 * pi * k * T_norm)) / (k ^ 2);
    end

    % scaling 
    tri_wave = 0.5 + (8 / pi ^ 2) * tri_wave;

    if tri_wave < D
        state = 1;  % transistor ON
    else
        state = 0;  % transistor OFF
    end
end