function tempFactor = f_temp()
    % Ask user for bioreactor temperature 
    T = input('Enter the bioreactor temperature: ');

    Q10 = 2.5;
    T_opt = 25; % Optimal temperature for C. reinhardtii is around 25
    tempFactor = Q10^((T - T_opt) / 10);
end
