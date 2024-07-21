function sensitivity_analysis()
    % Initial biomass concentration and maximum specific growth rate of algae 
    u_max = 0.7;
    X0 = 0.5;
    
    % Set bioreactor tank volume and flow rate
    F = 0.5;
    V = 5;

    % Define the time span (in hours) for the simulation
    tspan = [0 168]; % from 0 to 168 hours (1 week)

    % Range of temperatures for sensitivity analysis
    T_range = 15:5:35;
    tempFactors = arrayfun(@f_temp_helper, T_range);
    
    % Range of pH for sensitivity analysis
    pH_range = 5:1:9;
    pHFactors = arrayfun(@f_pH_helper, pH_range);
    
    % Range of light intensities for sensitivity analysis
    L_range = 50:25:150;
    lightFactors = arrayfun(@f_L_helper, L_range);
    
    % Range of nutrient concentrations for sensitivity analysis
    S_range = 0:5:20;
    nutrientFactors = arrayfun(@(S) f_nutrients_helper(1, S, 1), S_range);
    
    % Sensitivity analysis for temperature
    figure;
    hold on;
    for i = 1:length(T_range)
        u = u_max * tempFactors(i);
        D = F / V;
        Xmax = 25;
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Sensitivity Analysis: Temperature');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, T_range, 'UniformOutput', false));
    grid on;
    
    % Sensitivity analysis for pH
    figure;
    hold on;
    for i = 1:length(pH_range)
        u = u_max * pHFactors(i);
        D = F / V;
        Xmax = 25;
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Sensitivity Analysis: pH');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, pH_range, 'UniformOutput', false));
    grid on;
    
    % Sensitivity analysis for light intensity
    figure;
    hold on;
    for i = 1:length(L_range)
        u = u_max * lightFactors(i);
        D = F / V;
        Xmax = 25;
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Sensitivity Analysis: Light Intensity');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, L_range, 'UniformOutput', false));
    grid on;
    
    % Sensitivity analysis for nutrient concentration
    figure;
    hold on;
    for i = 1:length(S_range)
        u = u_max * nutrientFactors(i);
        D = F / V;
        Xmax = 25;
        [t, X] = ode45(@(t, X) ode_function(t, X, u, D, Xmax), tspan, X0);
        plot(t, X);
    end
    hold off;
    title('Sensitivity Analysis: Nutrient Concentration');
    xlabel('Time (hours)');
    ylabel('Biomass Concentration (g/L)');
    legend(arrayfun(@num2str, S_range, 'UniformOutput', false));
    grid on;
end

% Helper function for temperature sensitivity
function tempFactor = f_temp_helper(T)
    Q10 = 2.5;
    T_opt = 25; % Optimal temperature for C. reinhardtii is around 25
    tempFactor = Q10^((T - T_opt) / 10);
end

% Helper function for pH sensitivity
function pHFactor = f_pH_helper(pH)
    sigma = 1.25;
    pH_opt = 7; % Optimal pH for C. reinhardtii is around neutral
    pHFactor = exp(-((pH - pH_opt)^2) / (2 * sigma^2));
end

% Helper function for light intensity sensitivity
function lightFactor = f_L_helper(L)
    alpha = 1;
    L_opt = 100; % Optimal light intensity for C. reinhardtii
    lightFactor = 1 - exp(-alpha * L / L_opt);
end

% Helper function for nutrient concentration sensitivity
function nutrientFactor = f_nutrients_helper(~, S, K_s)
    nutrientFactor = S / (K_s + S);
end

function dXdt = ode_function(~, X, u, D, Xmax)
    dXdt = (u - D) * X * (1 - X / Xmax);
end
