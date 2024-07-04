function x1 = A_D_converter(filename)

    wavdata = audioread(filename,'native');
   
    binAudio = dec2bin(typecast(single(wavdata(:)), 'uint8'), 8) - '0';
    lenB = length(binAudio);
    x1 = reshape(binAudio,lenB*8,1);

 
end
