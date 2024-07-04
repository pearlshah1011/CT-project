ns = 20;
tps = 0.1;
f = 100;
t = 0:tps/f:ns*tps;
t = t(1:end-1);

c = cos(2*pi*t*f);
m = randbit(2*ns,2);
figure;
mf = reshape(m,1,2*ns);
stem(mf);
m = bitmap(m,"fourpammap");
figure;
stem(m);

m = upsample(m,f);
h = ones(1,f);
m = conv(m,h,"same");

s = m.*c;
figure;
plot(s);

sx = demodulator(s);
% sx = abs(hilbert(s));
figure;
plot(sx);

figure;
ld = lineDecoder(sx,f);
stem(ld);

dc = decoder(ld);
figure;
stem(dc);


