function [ F,G,C_K,per ] = GDJ_GCP( m,q )
% GDJ序列对，2020年7月3日20:26:12
% G,H为输出的GCP，int8类型数据，定义在Zq上
S = all_sequence(m,2);   % 存储0 - 2^m-1 所有数字的二进制表示
CK = all_sequence(m,q);  % 所有可以取到的c_k

P = perms(m:-1:1);    % 知道所有的置换

% 对置换做限制条件
new_ps = [];
for i = 1:size(P,1)
    p = P(i,:);
    if p(1) == m-1 && p(m) == m   %限制条件在此处增加
        new_ps = [new_ps;p];
    end
end

np = size(new_ps,1);
nck = size(CK,1);
% 开始跑
t = 1;
for ii = 1:np
     p = new_ps(ii,:);
     Sp = S(:,p);
     A = sum(Sp(:,1:m-1).*Sp(:,2:m),2);  % 二次项求和
     A = int8(A);
    for jj = 1:nck
        ck = CK(jj,:);
        B = double(S)*double(ck.'); % 一次项求和
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