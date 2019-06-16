one = load('slp61_c.mat');

energy_mat = [one.energy_mat(21:133,1:6) one.label(1:113)];
entropy_mat = [one.entropy_mat(21:133,1:6) one.label(1:113)];
skewness_mat = [one.skewness_mat(21:133,1:6) one.label(1:113)];
kurtosis_mat = [one.kurtosis_mat(21:133,1:6) one.label(1:113)];

save('slp61.mat', 'energy_mat','entropy_mat','skewness_mat','kurtosis_mat');    
 
