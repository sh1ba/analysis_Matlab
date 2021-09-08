%-------------------------------------------------
%�iPivot�I�����jGauss�̏����@�̃T���v���v���O����
%-------------------------------------------------



n=100;
A = rand(n);
x_exact = ones(n,1);   %�^�̉�
b=A*x_exact;%�E�Ӎ��̐ݒ�
x = zeros(n,1); %���x�N�g��x�i�[���x�N�g���ŏ������j

%�O�i�����ߒ�
for k=1:n-1
    
   %Pivot�I��--------------------------
    %�ő听���̍s��T��
    MAX = abs(A(k,k));
    pivot = k;
    for c=k+1:n
        if abs(A(c,k)) > MAX
            MAX = abs(A(c,k));
            pivot = c;
        end
    end
    if pivot ~= k
    %�s�̓���ւ�
        tmp = A(k, :);
        A(k, :) = A(pivot, :);
        A(pivot, :) = tmp;
    
    %�E�Ӎ�������ւ�
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

%�m�F�̂��ߏo��
disp(A)
disp(b)

%��ޑ���ߒ�
x(n,1) = b(n,1)/A(n,n);
for k=n-1:-1:1
    x(k,1)=b(k);
    for a=k+1:n
        x(k,1)=x(k,1)-A(k, a)*x(a,1);
    end
    x(k,1)=x(k,1) / A(k,k);
end
%�ߎ����̏o��
fprintf('�ߎ���x=\n');
disp(x)

%���Ύc���Q�m�����̌v�Z
zansa2norm = abs(A*x_exact - A*x)./abs(A*x_exact);%�E�ӂ�0���C��
fprintf('���Ύc���Q�m����=%e\n',zansa2norm)
%�^�̉��Ƌߎ����Ƃ̐�Ό덷�Q�m�����̌v�Z
gosa2norm = abs(x_exact - x);%�E�ӂ�0���C��
fprintf('��Ό덷�Q�m����=%e\n',gosa2norm)


semilogy(zansa2norm)
hold on
semilogy(gosa2norm)
legend('���Ύc���Q�m����','��Ό덷�Q�m����')