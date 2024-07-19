% Main Function
function tPBR()
    % Call factor functions
    tempFactor = f_temp();
    pHFactor = f_pH();
    lightFactor = f_L();
    nutrientFactor = f_nutrients();
    
    % Display factor values
    disp(['The temperature growth factor is: ', num2str(tempFactor)]);
    disp(['The pH growth factor is: ', num2str(pHFactor)]);
    disp(['The light growth factor is: ', num2str(lightFactor)]);
    disp(['The nutrient growth factor is: ', num2str(nutrientFactor)]);

    % Ask for initial biomass concentration and maximum specific growth rate of algae 
    u_max = 0.7;
    X0 = 0.5;

    % Set bioreactor tank volume and flow rate
    F = 0.5;
    V = 5;

    % Calculate specific growth rate and dilution rate
    u = u_max * tempFactor * pHFactor * nutrientFactor * lightFactor;
    D = F / V;

    % Display specific growth rate of algae
    disp(['The specific growth rate is: ', num2str(u)]);

    % Ask for the maximum biomass concentration (carrying capacity)
    Xmax = 25;

    % Define the time span (in hours) for the simulation
    tspan = [0 168]; % from 0 to 168 hours

    % Solve the ODE using ode45
    [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);

    % Plot the results
    figure;
    plot(t, X, '-o');
    title('Biomass Concentration Over Time with Carrying Capacity');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    grid on;
end

% ODE function with carrying capacity
function dXdt = ode_function(~, X, u, D, Xmax)
    dXdt = (u - D) * X * (1 - X / Xmax);
end

% This function calculates the effect on the growth factor due to temperature 
function tempFactor = f_temp()
    % Ask user for bioreactor temperature 
    T = input('Enter the bioreactor temperature: ');

    Q10 = 2.5;
    T_opt = 25; % Optimal temperature for C. reinhardtii is around 25
    tempFactor = Q10^((T - T_opt) / 10);
    
    % Range of temperatures for plotting
    T_range = 15:1:35;
    tempFactors = Q10.^((T_range - T_opt) / 10);
    
    % Optimal values for other parameters
    u_max = 0.7; % Assume some maximum specific growth rate
    X0 = 0.5; % Initial biomass concentration
    D = 0.5 / 5;
    Xmax = 25; % Assume some carrying capacity
    tspan = [0 168];

    % Plotting the effect of temperature on biomass concentration
    figure;
    hold on;
    for i = 1:length(T_range)
        u = u_max * tempFactors(i);
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Effect of Temperature on Biomass Concentration');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, T_range, 'UniformOutput', false));
    grid on;
end

% This function calculates the effect on the growth factor due to pH 
function pHFactor = f_pH()
    % Ask user for bioreactor pH
    pH = input('Enter the bioreactor pH: ');

    sigma = 1.25;
    pH_opt = 7; % Optimal pH for C. reinhardtii is around neutral
    pHFactor = exp(-((pH - pH_opt)^2) / (2 * sigma^2));
    
    % Range of pH for plotting
    pH_range = 5:0.1:9;
    pHFactors = exp(-((pH_range - pH_opt).^2) / (2 * sigma^2));
    
    % Optimal values for other parameters
    u_max = 0.7; % Assume some maximum specific growth rate
    X0 = 0.5; % Initial biomass concentration
    D = 0.5 / 5;
    Xmax = 25; % Assume some carrying capacity
    tspan = [0 168];

    % Plotting the effect of pH on biomass concentration
    figure;
    hold on;
    for i = 1:length(pH_range)
        u = u_max * pHFactors(i);
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Effect of pH on Biomass Concentration');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, pH_range, 'UniformOutput', false));
    grid on;
end

% This function calculates the effect on the growth factor due to light
function lightFactor = f_L()
    % Ask user for light intensity
    L = input('Enter the bioreactor light intensity: ');

    alpha = 1;
    L_opt = 100; % Optimal light intensity for C. reinhardtii
    lightFactor = 1 - exp(-alpha * L / L_opt);
    
    % Range of light intensity for plotting
    L_range = 50:10:150;
    lightFactors = 1 - exp(-alpha * L_range / L_opt);
    
    % Optimal values for other parameters
    u_max = 0.7; % Assume some maximum specific growth rate
    X0 = 0.5; % Initial biomass concentration
    D = 0.5 / 5;
    Xmax = 25; % Assume some carrying capacity
    tspan = [0 168];

    % Plotting the effect of light intensity on biomass concentration
    figure;
    hold on;
    for i = 1:length(L_range)
        u = u_max * lightFactors(i);
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Effect of Light Intensity on Biomass Concentration');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, L_range, 'UniformOutput', false));
    grid on;
end

% This function calculates the effect on growth factor based on multiple nutrients using the Monod equation
function nutrientFactor = f_nutrients()
    % Ask the user for the number of nutrients
    numNutrients = input('Enter the number of nutrients: ');

    % Initialize arrays to store nutrient concentrations and half-saturation constants
    S = zeros(1, numNutrients);
    K_s = zeros(1, numNutrients);

    % Ask user for the nutrient concentrations and half-saturation constants for each nutrient
    for i = 1:numNutrients
        S(i) = input(['Enter the concentration of nutrient S', num2str(i), ': ']);
        K_s(i) = input(['Enter the half-saturation constant K_{s', num2str(i), '}: ']);
    end

    % Calculate the Monod expressions for each nutrient
    monodExpressions = S ./ (K_s + S);

    % Calculate the nutrient growth factor as the minimum of the Monod expressions
    nutrientFactor = min(monodExpressions);
    
    % Assume a single nutrient for plotting
    S_opt = 10;
    K_s_opt = 1;

    % Range of nutrient concentrations for plotting
    S_range = 0:1:20;
    nutrientFactors = S_range ./ (K_s_opt + S_range);
    
    % Optimal values for other parameters
    u_max = 0.7; % Assume some maximum specific growth rate
    X0 = 0.5; % Initial biomass concentration
    D = 0.5 / 5;
    Xmax = 25; % Assume some carrying capacity
    tspan = [0 168];

    % Plotting the effect of nutrient concentration on biomass concentration
    figure;
    hold on;
    for i = 1:length(S_range)
        u = u_max * nutrientFactors(i);
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Effect of Nutrient Concentration on Biomass Concentration');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, S_range, 'UniformOutput', false));
    grid on;
end

% Call main function
tPBR();
