function map = bitmap(bits,type)

if(type=="bpskmap")
    map(bits==1) = 1;
    map(bits==0) = -1;

elseif(type=="qpskmap")
    map(all(bits==[0;0])) = 1+1j;  
    map(all(bits==[0;1])) = -1+1j;
    map(all(bits==[1;0])) = 1-1j;
    map(all(bits==[1;1])) = -1-1j;

elseif(type=="fourpammap") % recheck once
    map(all(bits==[0;0])) = 0;
    map(all(bits==[0;1])) = 1;
    map(all(bits==[1;0])) = 2;
    map(all(bits==[1;1])) = 3;

elseif(type=="sixteenqammap")
    map(all(bits==[0;0;0;0])) = -3-3j;
    map(all(bits==[0;0;0;1])) = -3-1j;
    map(all(bits==[0;0;1;0])) = -3+3j;
    map(all(bits==[0;0;1;1])) = -3+1j;

    map(all(bits==[0;1;0;0])) = -1-3j;
    map(all(bits==[0;1;0;1])) = -1-1j;
    map(all(bits==[0;1;1;0])) = -1+3j;
    map(all(bits==[0;1;1;1])) = -1+1j;

    map(all(bits==[1;0;0;0])) = 1-3j;
    map(all(bits==[1;0;0;1])) = 1-1j;
    map(all(bits==[1;0;1;0])) = 1+3j;
    map(all(bits==[1;0;1;1])) = 1+1j;

    map(all(bits==[1;1;0;0])) = 3-3j;
    map(all(bits==[1;1;0;1])) = 3-1j;
    map(all(bits==[1;1;1;0])) = 3+3j;
    map(all(bits==[1;1;1;1])) = 3+1j;

elseif(type=="eightpskmap")
    map(all(bits==[0;0;0])) = exp(2j*pi*0/8);
    map(all(bits==[0;0;1])) = exp(2j*pi*1/8);
    map(all(bits==[0;1;0])) = exp(2j*pi*3/8);
    map(all(bits==[0;1;1])) = exp(2j*pi*2/8);

    map(all(bits==[1;0;0])) = exp(2j*pi*7/8);
    map(all(bits==[1;0;1])) = exp(2j*pi*6/8);
    map(all(bits==[1;1;0])) = exp(2j*pi*4/8);
    map(all(bits==[1;1;1])) = exp(2j*pi*5/8);
end
end


