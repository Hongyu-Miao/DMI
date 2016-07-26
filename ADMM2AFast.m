function [ C ] = ADMM2AFast( D,X,N,alpha,beta,K,BgNet,gsd)

    iteration = 10;
    
    A = sparse(N,N);
    B = A;
    C = A;
    U = A;
    rho =1;
    gamma = 1/(norm(X)^2+rho);
    gammarho = gamma*rho;
    gammaBgNet = gamma * BgNet;
    bgBgNet = beta * gammaBgNet;

    for i = 1 : K
        t1 = 1; t2 = 1;
        Apseudo = A;
        Bpseudo = B;

       for j = 1 : 10
            W = Apseudo -  (((Apseudo+B)*X-D)*X'.*gammaBgNet + gammarho * (Apseudo + B - C) +gamma*U);
            A1 = W*sparse(1:N,1:N,max(0,1-gamma * alpha./(sqrt(sum(W.^2))+eps)),N,N);
            t3 = 0.5 + 0.5 * sqrt(1 + 4 * t2^2);
            r = (t2-1)/t3;
            Apseudo = (1+r) * A1 - r*A;
            A = A1;
            t1 = t2;
            t2 = t3;  
            R = Bpseudo - (((A+Bpseudo)*X - D)*X'.*gammaBgNet + gammarho * (A + Bpseudo -C) + gamma*U);
            B1 = sign(R).*max(0,abs(R) - bgBgNet);
            Bpseudo = (1+r) * B1 - r*B;
            B = B1;
        end


        C = A+B+1/rho*U;
        C = lzeroProj(C,gsd);
        U = U + rho * (A+B-C);
        if mod(i,10)==0
           fprintf('DMI core %d round Ok!\n', i);
        end
    end
end

