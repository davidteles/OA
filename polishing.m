function [sinal]=polishing(y,t_pol)
sz=size(t_pol);
p=sz(2);

cvx_begin quiet;
    n=1000;
    variable alfa(n);
    variable betax(n);
    i=1;
    for k=1:(p-1)
        for t=(t_pol(k))+1:(t_pol(k+1))
            x(i)=alfa(k)+betax(k)*t;    
            i=i+1;
        end
    end
    for k=1:(p-2)
        alfa(k)+betax(k)*t_pol(k+1)==alfa(k+1)+betax(k+1)*t_pol(k+1);
    end
    
    f=sum_square_abs(y-x');
    minimize(f);
    
    sinal=x;
    
cvx_end;