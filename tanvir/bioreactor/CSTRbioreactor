% Main Function
function bioreactorCSTR()

    % Call factor functions
    tempFactor = f_temp();
    pHFactor = f_pH();
    illuminationFactor = f_I();
    substrateFactor = f_substrates();
    
    % Display factor values
    disp(['The temperature growth factor is: ', num2str(tempFactor)]);
    disp(['The pH growth factor is: ', num2str(pHFactor)]);
    disp(['The illumination growth factor is: ', num2str(illuminationFactor)]);
    disp(['The substrate growth factor is: ', num2str(substrateFactor)]);

    % Ask for initial biomass concentration and maximum specific growth rate of algae 
    u_max = input('Enter the maximum specific growth rate of the algae (1/h): ');
    X0 = input('Enter the initial biomass concentration of algae (g/L): ');

    % Ask for bioreactor tank volume and flow rate
    F = input('Enter the bioreactor tank flow rate (L/h): ');
    V = input('Enter the bioreactor tank volume (L): ');

    % Calculate specific growth rate and dilution rate
    u = u_max * tempFactor * pHFactor * substrateFactor;
    D = F / V;

    % Display specific growth rate of algae
    disp(['The specific growth rate is: ', num2str(u)]);

    % Define the time span (in hours) for the simulation
    tspan = [0 168]; % from 0 to 168 hours

    % Define the ODE function with explicit handling of the initial condition
    function dXdt = ode_function(t, X, X0, u, D)
        if t == tspan(1)
            dXdt = X0;
        else
            dXdt = (u - D) * X;
        end
    end

    % Solve the ODE
    [t, X] = ode45(@(t, X) ode_function(t, X, X0, u, D), tspan, X0);

    % Plot the results
    figure;
    plot(t, X, '-o');
    title('Algae Biomass Concentration Over Time in a CSTR Bioreactor');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    grid on;
    
    % Calculate the minimum and maximum concentration values
    minConcentration = min(X);
    maxConcentration = max(X);
    
    % Set y-axis limits with some buffer for better visualization
    yAxisBuffer = 10; % Adjust as needed
    ylim([minConcentration - yAxisBuffer, maxConcentration + yAxisBuffer]);

end

% ODE function for biomass balance
function dXdt = ode_function(~, X, u, D)
    dXdt = u * X - D * X;
end

% This function calculates the effect on the growth factor due to temperature 
function tempFactor = f_temp()
    
    % Ask user for temperature, optimal temperature and Q10 value
    T = input('Enter the bioreactor temperature: ');
    T_opt = input('Enter the optimal temperature for algae growth: ');
    Q10 = input('Enter Q10 value: ');

    % Calculate the temperature growth factor
    tempFactor = Q10^((T - T_opt) / 10);
end

% This function calculates the effect on the growth factor due to pH 
function pHFactor = f_pH()
    
    % Ask user for pH, optimal pH and sigma
    % Sigma = standard deviation determining the pH range for optimal growth
    pH = input('Enter the bioreactor pH: ');
    pH_opt = input('Enter the optimal pH for algae growth: ');
    sigma = input('Enter sigma value: ');

    % Calculate the pH growth factor
    pHFactor = exp(-((pH - pH_opt)^2) / (2 * sigma^2));
end

% This function calculates the effect on the growth factor due to illumination
function illuminationFactor = f_I()
   
    % Ask user for light intensity, optimal light intensity and alpha
    % Light intensity in µmol photons m^(-2) s^(-1)
    % Alpha = Initial slope of the P-I curve
    I = input('Enter the bioreactor light intensity: ');
    I_opt = input('Enter the optimal light intensity for algae growth: ');
    alpha = input('Enter alpha value: ');
    
    illuminationFactor = 1 - exp(-alpha * I / I_opt);
end

% This function calculates the effect on growth factor based on multiple using the Monod equation.
function substrateFactor = f_substrates()
    % Ask the user for the number of substrates
    numSubstrates = input('Enter the number of substrates: ');

    % Initialize arrays to store substrate concentrations and half-saturation constants
    S = zeros(1, numSubstrates);
    K_s = zeros(1, numSubstrates);

    % Ask user for the substrate concentrations and half-saturation constants for each substrate
    for i = 1:numSubstrates
        S(i) = input(['Enter the concentration of substrate S', num2str(i), ': ']);
        K_s(i) = input(['Enter the half-saturation constant K_{s', num2str(i), '}: ']);
    end

    % Calculate the Monod expressions for each substrate
    monodExpressions = S ./ (K_s + S);

    % Calculate the substrate growth factor as the minimum of the Monod expressions
    substrateFactor = min(monodExpressions);
end

% Call main function
bioreactorCSTR();
