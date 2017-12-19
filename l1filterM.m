function [sinal,spikes]=l1filterM(y,lbda,P)

cvx_begin quiet;
    n=size(y,1);
    variable x(n);
    variable u(n);
    
    %Calculo da second-order difference matrix (D)
    nOnes = ones(n, 1) ;
    Dtemp = diag(2 * nOnes, 0) - diag(nOnes(1:n-1), -1) - diag(nOnes(1:n-1), 1);
    D = Dtemp( [2:end-1] , : );
     
    
    %Calculo do maxlbda
    %maxlbda = norm(inv(D*D')*D*y,inf)
    %if lbda>=maxlbda
    %    lbda=maxlbda;
    %end
    
    %Identificar kink points e aplicar Polishing
    
    %Cost function na forma matricial e respectiva minimizacao e output
    f=(1/2)*sum_square_abs((y-x-u))+lbda*norm(D*x,1)+P*norm(u,1);
    minimize(f);
    sinal=x;
    spikes=u;
    
cvx_end;