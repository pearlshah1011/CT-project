function symbol = ask(bits)
    
    mapping = [0, 1, 2, 3];
    index = bits(1) * 2 + bits(2) + 1;
    %-0 = [0 0 ]
    %-1=[0 1]
    %2 =[1 0]
    %3 =[1 1]
  
    symbol = mapping(index);
end