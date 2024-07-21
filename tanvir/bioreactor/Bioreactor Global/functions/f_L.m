function lightFactor = f_L()
    % Ask user for light intensity
    L = input('Enter the bioreactor light intensity: ');

    alpha = 1;
    L_opt = 100; % Optimal light intensity for C. reinhardtii
    lightFactor = 1 - exp(-alpha * L / L_opt);
end
