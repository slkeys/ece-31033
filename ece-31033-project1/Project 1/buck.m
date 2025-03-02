while t(n) < t_end
    % call swt within loop
    switch_state = swt(D, t(n));

    % inductor voltage
    % switch ON
    if switch_state == 1
        V_L = V_in - V_C(n);
    % switch OFF
    else
        V_L = -V_C(n);
    end

    % trapezoidal integration for I_L
    I_L(n + 1) = I_L(n) + (dt / (2 * L)) * (2 * V_L);
    I_L(n + 1) = max(I_L(n + 1), 0);    % inductor current cannot go below 0 A

    % cap current
    I_C(n) = I_L(n) - (V_C(n) / R_loadMax);

    % trapezoidal integration for V_C
    V_C(n + 1) = V_C(n) + (dt / (2 * C)) * (2 * I_C(n));

    % store the state
    states(n) = switch_state;

    % increment loop variable
    t(n + 1) = t(n) + dt;
    n = n + 1;
end

t = t(1 : n - 1);
I_L = I_L(1 : n - 1);
V_C = V_C(1 : n - 1);
states = states(1 : n - 1);
