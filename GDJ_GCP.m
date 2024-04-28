function [ F,G,C_K,per ] = GDJ_GCP( m,q )
% GDJ���жԣ�2020��7��3��20:26:12
% G,HΪ�����GCP��int8�������ݣ�������Zq��
S = all_sequence(m,2);   % �洢0 - 2^m-1 �������ֵĶ����Ʊ�ʾ
CK = all_sequence(m,q);  % ���п���ȡ����c_k

P = perms(m:-1:1);    % ֪�����е��û�

% ���û�����������
new_ps = [];
for i = 1:size(P,1)
    p = P(i,:);
    if p(1) == m-1 && p(m) == m   %���������ڴ˴�����
        new_ps = [new_ps;p];
    end
end

np = size(new_ps,1);
nck = size(CK,1);
% ��ʼ��
t = 1;
for ii = 1:np
     p = new_ps(ii,:);
     Sp = S(:,p);
     A = sum(Sp(:,1:m-1).*Sp(:,2:m),2);  % ���������
     A = int8(A);
    for jj = 1:nck
        ck = CK(jj,:);
        B = double(S)*double(ck.'); % һ�������
        B = int8(B);
        for c1 = 0:0
            f = mod(int8(q/2)*A+B+1,q);
            g = mod(int8(q/2)*A+B+int8(q/2)*Sp(:,1)+1,q);
            F(t,:) = f.'; G(t,:) = g.';
            C_K(t,:) = ck; per(t,:) = p;
            t = t + 1;
        end
    end
end
end