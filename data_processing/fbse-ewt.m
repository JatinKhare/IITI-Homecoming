skewness_mat = zeros(134,6); kurtosis_mat = zeros(134,6); entropy_mat = zeros(134,6);energy_mat = zeros(134,6);
imf_mat_slp02am_3 = zeros(134,6);

x=load('slp02am.mat'); % input signal
d = x.val;
Fs = 250; duration = 0.5;
signals = zeros(7500,133);
for i = 1:133
    signals(:,i) = d(:,(i-1)*7500+1:i*7500);
end
signals(1:2500,134) = d(:,133*7500+1:end);
eeg_data = signals';


%{
[h,f]= freqz(b,a,256,250);
H= 20*log10(abs(h));

N = 7500;
dF = Fs/N;                      
f = -Fs/2:dF:Fs/2-dF; 


fdt = fftshift(fft(dt));
fy = fftshift(fft(y));
figure;

figure;
subplot(3,1,1)
plot(dt);title('Original Signal');axis tight;
subplot(3,1,2)
plot(y);title('Filtered Signal');axis tight;
subplot(3,1,3)
plot(f,abs(fdt));hold on;
plot(f,abs(fy));
title('Freq. Response BandPass Cutoff Freq = 35Hz to 105Hz');axis tight;
legend('Original','Filtered')
%}


for count = 76:134
dt = eeg_data(count,:);
f=transpose(dt);

%{
figure
subplot(4,1,1)
plot(y)
set(findobj(gca,'type','line'),'linew',2);
grid on; title('Bessel EEG')
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
params_selection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subresf=1;
[freq1,freq1_bndr,freq2,a3,ewt,mfb,boundaries,boundaaries2,mfb2]=FBexp(f,params);


rec=Modes_EWT1D(ewt,mfb);
for i=1:6
imf(i,:)=rec{i,1};
end

%{
figure;
subplot(8,1,1)
plot(imf(1,:));axis tight; grid on;
subplot(8,1,2)
plot(imf(2,:));axis tight; grid on;
subplot(8,1,3)
plot(imf(3,:));axis tight; grid on;
subplot(8,1,4)
plot(imf(4,:));axis tight; grid on;
subplot(8,1,5)
plot(imf(5,:));axis tight; grid on;
subplot(8,1,6)
%}
pskweness = zeros(6,1);
pkurtosis = zeros(6,1);
pentropy = zeros(6,1);
penergy = zeros(6,1);
for q = 1:6
pskweness(q,1) = skewness(imf(q,:));
pkurtosis(q,1) = kurtosis(imf(q,:));
pentropy(q,1) = entropy(imf(q,:));
penergy(q,1) = sum((imf(q,:)).^2);

end
skewness_mat(count, :) = transpose(pskweness);
kurtosis_mat(count, :) = transpose(pkurtosis); 
entropy_mat(count, :) = transpose(pentropy);
energy_mat(count, :) = transpose(penergy);
imf_mat_slp02am_3 = imf(1:6,:);
save('final_values_slp02am_3.mat', 'skewness_mat','kurtosis_mat','entropy_mat','energy_mat');
save('imf_final_slp02am_3.mat','imf_mat_slp02am_3');
end
