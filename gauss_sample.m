%-------------------------------------------------
%（Pivot選択つき）Gaussの消去法のサンプルプログラム
%-------------------------------------------------



n=100;
A = rand(n);
x_exact = ones(n,1);   %真の解
b=A*x_exact;%右辺項の設定
x = zeros(n,1); %解ベクトルx（ゼロベクトルで初期化）

%前進消去過程
for k=1:n-1
    
   %Pivot選択--------------------------
    %最大成分の行を探す
    MAX = abs(A(k,k));
    pivot = k;
    for c=k+1:n
        if abs(A(c,k)) > MAX
            MAX = abs(A(c,k));
            pivot = c;
        end
    end
    if pivot ~= k
    %行の入れ替え
        tmp = A(k, :);
        A(k, :) = A(pivot, :);
        A(pivot, :) = tmp;
    
    %右辺項も入れ替え
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

%確認のため出力
disp(A)
disp(b)

%後退代入過程
x(n,1) = b(n,1)/A(n,n);
for k=n-1:-1:1
    x(k,1)=b(k);
    for a=k+1:n
        x(k,1)=x(k,1)-A(k, a)*x(a,1);
    end
    x(k,1)=x(k,1) / A(k,k);
end
%近似解の出力
fprintf('近似解x=\n');
disp(x)

%相対残差２ノルムの計算
zansa2norm = abs(A*x_exact - A*x)./abs(A*x_exact);%右辺の0を修正
fprintf('相対残差２ノルム=%e\n',zansa2norm)
%真の解と近似解との絶対誤差２ノルムの計算
gosa2norm = abs(x_exact - x);%右辺の0を修正
fprintf('絶対誤差２ノルム=%e\n',gosa2norm)


semilogy(zansa2norm)
hold on
semilogy(gosa2norm)
legend('相対残差２ノルム','絶対誤差２ノルム')