clear all;
close all;
filename = 'project.wav';

% A/D converter
x1 = A_D_converter(filename);

start_idx=1;
end_idx=100;
x1=x1(start_idx:end_idx);
length_x1 = size(x1);

% Encoder
x2 = zeros(1, length_x1(1)/2);
for i = 1:2:length_x1-1
    bits_pair = x1(i:i+1);
    x2((i+1)/2) = ask(bits_pair);
end

% Line Coding
oversampling_factor = 4;  % Reduced oversampling factor
m = oversampling_factor;
a = 0.5;
length = 10;
[raised_cosine_filter, dummy] = raised_cosine(a, m, length);
rect_filter = ones(1, 4);  % Adjusted pulse size

nsymbols = length_x1(1)/2;
nsymbols_upsampled = 1 + (nsymbols-1) * m;
symbols_upsampled = zeros(nsymbols_upsampled, 1);
symbols_upsampled(1:m:end) = x2;

x3_rcos = conv(symbols_upsampled, raised_cosine_filter, 'same');
x3_rect = conv(symbols_upsampled, rect_filter, 'same');
len_x3rcos=size(x3_rect);
% Modulation Segment by Segment


Tb = 0.25;
fc = 1;
% Assuming x3_rect is defined elsewhere in your code.
total_samples = len_x3rcos(1);
Fs=1e6;
t = 0:Tb:(len_x3rcos-1)*Tb;
carrier = cos(2*pi*fc*t)';

x4 = carrier .* x3_rcos;


EbN0_dB = 0:2:20; % Range of Eb/N0 values in dB

% Initialize error vector
Pe = zeros(11, 1);

figure;
for idx = 1:11
    % Add AWGN
    y4 = memoryless_awgn_channel(x4, EbN0_dB(idx)); % Custom function to add noise

   y3 = demodulator(y4);

    
    y2 = lineDecoder(y3,m);
    subplot(3,4,idx);
    plot(real(y2), imag(y2), 'ro');
    title('Output Constellation for ',num2str(EbN0_dB(idx)));
    xlabel('In-phase');
    ylabel('Quadrature');
    axis square;

    
    y1 = decoder(y2);

    % Calculate bit errors
    errors = sum(x1 ~= y1);

    % Calculate probability of error
    Pe(idx) = errors / length_x1(1); 
    
end






figure;
semilogy(EbN0_dB, Pe, '-o');
title('Probability of Error vs. E_b/N_0');
xlabel('E_b/N_0 (dB)');
ylabel('Probability of Error (P_e)');
grid on;

disp("Mean Square Error is-");
disp(rmse(y1,x1));


% Plot x1 and y1
figure;
subplot(2, 1, 1);
stem(x1, 'filled');
title('Original Bits x1');
xlabel('Sample Index');
ylabel('Amplitude');

subplot(2, 1, 2);
stem(y1, 'filled');
title('Received Bits y1');
xlabel('Sample Index');
ylabel('Amplitude');

% Plot x2 and y2
figure;
subplot(2, 1, 1);
stem(x2, 'filled');
title('Encoded Bits x2');
xlabel('Sample Index');
ylabel('Amplitude');

subplot(2, 1, 2);
stem(y2, 'filled');
title('Decoded Bits y2');
xlabel('Sample Index');
ylabel('Amplitude');

% Plot x3_rect and y3
figure;
subplot(2, 1, 1);
plot(x3_rcos);
title('Line Coded Signal x3\_rect');
xlabel('Sample Index');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(y3);
title('Received Line Coded Signal y3');
xlabel('Sample Index');
ylabel('Amplitude');

% Plot x4 and y4
figure;
subplot(2, 1, 1);
stem(x4);
title('Modulated Signal x4');
xlabel('Sample Index');
ylabel('Amplitude');

subplot(2, 1, 2);
stem(y4);
title('Received Modulated Signal y4');
xlabel('Sample Index');
ylabel('Amplitude');




