function y1 = decoder(y2)
    y1 = [];
    for i = y2'
        if(i>2.5)
            y1 = [y1;1;1];
        elseif (i>1.5)
            y1 = [y1;1;0];
        elseif (i>0.5)
            y1 = [y1;0;1];
        elseif (i>0)
            y1 = [y1;0;0];
        end
    end
end