one = load('final_values_slp37.mat');
two = load('final_values_slp37_2.mat');

one.energy_mat(77:end,:) = two.energy_mat(77:end,:);
one.entropy_mat(77:end,:) = two.entropy_mat(77:end,:);
one.skewness_mat(77:end,:) = two.skewness_mat(77:end,:);
one.kurtosis_mat(77:end,:) = two.kurtosis_mat(77:end,:);
energy_mat = one.energy_mat;
entropy_mat = one.entropy_mat;
skewness_mat = one.skewness_mat;
kurtosis_mat = one.kurtosis_mat;
save('final_values_slp37_merged', 'energy_mat','entropy_mat','skewness_mat','kurtosis_mat');

 
