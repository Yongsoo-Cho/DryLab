function pHFactor = f_pH()
    % Ask user for bioreactor pH
    pH = input('Enter the bioreactor pH: ');

    sigma = 1.25;
    pH_opt = 7; % Optimal pH for C. reinhardtii is around neutral
    pHFactor = exp(-((pH - pH_opt)^2) / (2 * sigma^2));
end
