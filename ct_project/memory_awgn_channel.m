function y = memory_awgn_channel(x, EbN0_dB, a, b,Tb)
   
 
    A = 1;
    B = zeros(1,b*Tb);
    B(1) = a;
    B(end) = (1-a);

    % Filter the input signal through the channel
    x_filtered = filter(B, A, x);

     y=awgn(x_filtered,EbN0_dB);
end

