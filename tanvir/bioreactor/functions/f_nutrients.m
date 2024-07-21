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
end
