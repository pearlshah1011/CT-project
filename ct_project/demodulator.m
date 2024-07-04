function y3 = demodulator(y4)
    %using hilbert filter
    y3 = abs(hilbert(y4));

    % implementing a envelop detector with decay rate dr
    % y3 = zeros(1,length(hf));
    % ev = -inf;
    % ip = -inf;
    % for i=hf
    %     if i>=ev
    %         ev = i;
    %     elseif i<ev
    %         if i==0 && ip==0
    %             ev=0;
    %         else
    %             ev = ev-ev*dr;
    %         end
    %     end
    %     ip = i;
    %     y3 = [y3,ev];
    % end
end

