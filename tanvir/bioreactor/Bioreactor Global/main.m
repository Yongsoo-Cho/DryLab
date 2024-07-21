addpath('functions');

tPBR();


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

    % Perform sensitivity analysis
    sensitivity_analysis();
end


function dXdt = ode_function(~, X, u, D, Xmax)
    dXdt = (u - D) * X * (1 - X / Xmax);
end
