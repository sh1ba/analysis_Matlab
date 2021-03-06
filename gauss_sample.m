%-------------------------------------------------
%iPivotIðÂ«jGaussÌÁ@ÌTvvO
%-------------------------------------------------



n=100;
A = rand(n);
x_exact = ones(n,1);   %^Ìð
b=A*x_exact;%EÓÌÝè
x = zeros(n,1); %ðxNgxi[xNgÅú»j

%OiÁßö
for k=1:n-1
    
   %PivotIð--------------------------
    %Åå¬ªÌsðT·
    MAX = abs(A(k,k));
    pivot = k;
    for c=k+1:n
        if abs(A(c,k)) > MAX
            MAX = abs(A(c,k));
            pivot = c;
        end
    end
    if pivot ~= k
    %sÌüêÖ¦
        tmp = A(k, :);
        A(k, :) = A(pivot, :);
        A(pivot, :) = tmp;
    
    %EÓàüêÖ¦
        tmp_r = b(k);
        b(k) = b(pivot);
        b(pivot) = tmp_r;
    end
    %-----------------------------------   
    for i=k+1:n
        weight = A(i, k)/A(k, k);
        for m=k:n
            A(i, m)=A(i,m)-weight*A(k, m);
        end
        b(i) = b(i)-weight*b(k);
    end
end

%mFÌ½ßoÍ
disp(A)
disp(b)

%ãÞãüßö
x(n,1) = b(n,1)/A(n,n);
for k=n-1:-1:1
    x(k,1)=b(k);
    for a=k+1:n
        x(k,1)=x(k,1)-A(k, a)*x(a,1);
    end
    x(k,1)=x(k,1) / A(k,k);
end
%ßðÌoÍ
fprintf('ßðx=\n');
disp(x)

%Îc·QmÌvZ
zansa2norm = abs(A*x_exact - A*x)./abs(A*x_exact);%EÓÌ0ðC³
fprintf('Îc·Qm=%e\n',zansa2norm)
%^ÌðÆßðÆÌâÎë·QmÌvZ
gosa2norm = abs(x_exact - x);%EÓÌ0ðC³
fprintf('âÎë·Qm=%e\n',gosa2norm)


semilogy(zansa2norm)
hold on
semilogy(gosa2norm)
legend('Îc·Qm','âÎë·Qm')